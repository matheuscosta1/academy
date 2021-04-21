# trabalho-1.asm
#
# DESC:
# 	Escreva em assembly um programa que implementa o algoritmo de ordenacao quicksort. 
# 	O programa deve ler um arquivo texto chamado numeros.csv (nos arquivos do grupo) e ordena-los.  
# 	O programa deve ainda possuir uma funcao que converte uma string de numeros para um inteiro.
#
# DDA: 11-04-2021

.macro printStr(%str)
	la $a0, %str
	li $v0, 4
	syscall
.end_macro 

.macro printInt(%int)
	add $a0, $zero, %int
	li $v0, 1
	syscall
.end_macro 

.macro openFile(%file)
	la $a0, %file
	li $a1, 0
	li $a2, 0
	li $v0, 13
	syscall
.end_macro 

.macro closeFile(%file)
	add $a0, $zero, %file
	li $v0, 16
	syscall
.end_macro 

.macro endProgram()
	# Finaliza o programa
	li $v0, 10
	syscall
.end_macro 

.data
	array: .space 40000
	buffer: .space 6
	nan_v: .asciiz ","
	nan_e: .asciiz " "
	enter: .asciiz "\n"
	title: .asciiz "AOC1 - Trabalho 1\n"
	description: .asciiz "Ler numeros de um arquivo, ordena-los e printa-los.\n\n"
	error: .asciiz "Ih, deu caquinha em algum lugar... Boa sorte debugando!"
	file: .asciiz "numeros.csv"

.text
	printStr(title) # Imprime titulo do programa
	printStr(description) # Imprime descricao do programa
	
	# $s0: File Descriptor
	# $s1: array
	# $s2: buffer
	# $s3: Contador de carateres lidos no buffer
	# $s5: Resultado da leitura do arquivo
	# $s6: nan_v
	# $s7: nan_e
	
	# Abrir arquivo
	
	openFile(file) # Abre arquivo em modo de leitura
	slt $t0, $v0, $zero # O File Descriptor e menor que 0? (Retorna 1 se SIM, 0 se NAO)
	bne $t0, $zero, ERROR # Se o File Descriptor e menor que 0, fecha o programa
	add $s0, $v0, $zero # Salva o File Descriptor no $s0

	la $s1, array # Carregar endereco do array

	# Percorrer o arquivo	

	la $t1, nan_v
	lb $s6, 0($t1)
	la $t1, nan_e
	lb $s7, 0($t1)
START_READ:

	## Ler todos os digitos
	la $s2, buffer # Carregar endereco do buffer
	add $s3, $zero, $zero # Zerar contador 
DO_WHILE1:
	### Loop __________
	
	li $v0, 14 # Carrega o codigo de leitura de arquivo
	add $a0, $zero, $s0 # Carrega o File Descriptor
	add $a1, $zero, $s2 # Carrega o endereco do buffer
	li $a2, 1 # Carrega o numero de caracteres a serem lidos
	syscall
	
	### _______________
	
	slt $t0, $v0, $zero # O retorno da leitura do arquivo foi um número negativo?
	bne $t0, $zero, ERROR # Se sim, deu erro, encerra o programa
	
	beq $v0, $zero, END_DO_WHILE1 # Se nao houver elementos no arquivo, sai
	
	addi $s3, $s3, 1 # Incrementa o contador de caracteres lidos
	lb $t0, 0($s2) # Carrega o caractere lido
	
	beq $t0, $s6, END_DO_WHILE1 # Se o caractere livo for ",", sai
	beq $t0, $s7, END_DO_WHILE1 # Se o caractere livo for " ", sai
	
	addi $s2, $s2, 1 # O buffer vai para a proxima posicao
	
	j DO_WHILE1
	
END_DO_WHILE1:
	add $s5, $zero, $v0 # Resultado da leitura do arquivo
	
	addi $s3, $s3, -1 # Apenas pra facilicar as comparacoes, tirando espaco ou virgula
	beq $s3, $zero, JUMP1 # Se leu virgula, pula
	
	## Converter numero
	la $a0, buffer # Carrega endereco do buffer
	add $a1, $zero, $s3 # Carrega o numero de caracteres lidos
	
	jal strToInt
	
	## Salvar na memoria
	sw $v0, 0($s1) # Guardar o numero convertido no array
	addi $s1, $s1, 4 # Ir para a proxima posicao do array
	printInt($v0)
	printStr(enter)
	
JUMP1:
	bne $s5, $zero, START_READ # Se ainda houver elementos no arquivo, continue lendo
	
	## Imprimir o array
	
	closeFile($s0) # Fecha o arquivo

	endProgram()

ERROR:
	printStr(error)
	endProgram()




	
	# Funcao para converter string para numero
strToInt:
	## Salvar contexto na pilha
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s6, 12($sp)
	sw $s7, 16($sp)
	
	add $s0, $zero, $a0 # Endereco do array
	add $s1, $zero, $a1 # Numero de caracteres no array (-1 só para a condicao do FOR)
	li $s6, 10 # Base de convercao
	li $s7, 0 # Acumulador
	
FOR_STI:
	slt $t0, $zero, $s1
	beq $t0, $zero, END_FOR_STI
	
	## Loop __________
	
	add $a0, $zero, $s6 # Carrega a base
	addi $a1, $s1, -1 # Carrega o expoente
	jal potencia # Calcula a potencia
	
	lb $t1, 0($s0) # Carrega a casa decimal
	addi $t1, $t1, -48 # Normaliza o numero de acordo com a tabela ASCII
	mul $t3, $v0, $t1 # Multiplica a casa decimal com seu valor correspontente
	add $s7, $s7, $t3 # Soma no acumulador
	
	## _______________

	addi $s0, $s0, 1 # Incrementa a posicao do array
	addi $s1, $s1, -1 # Decrementa o contador
	j FOR_STI
	
END_FOR_STI:	
	add $v0, $zero, $s7 # "Retorna" o valor resultante

	## Restaurar contexto da pilha
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s6, 12($sp)
	lw $s7, 16($sp)
	addi $sp, $sp, 20
	
	## Voltar para o programa principal
	jr $ra





potencia:
	# Salvar contexto na pilha
	addi $sp, $sp, -16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $ra, 12($sp)

	add $s0, $zero, $a0 # Carrega a base
	add $s1, $zero, $a1 # Carrega o expoente
	li $s2, 1 # Acumulador
	
FOR_POT:
	slt $t0, $zero, $s1 # 0 < Expoente?
	beq $t0, $zero, END_FOR_POT # Se sim, sai
	
	## Loop __________
	
	mul $s2, $s2, $s0 # Calculo da potencia
	
	## _______________
	
	addi $s1, $s1, -1 # Decrementa o contador
	j FOR_POT
	
END_FOR_POT:
	add $v0, $zero, $s2 # "Retorna" o valor resultante
	#printInt($s1)
	# Restaurar contexto da pilha
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	
	jr $ra
	
	