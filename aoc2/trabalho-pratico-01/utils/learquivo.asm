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
	file: .asciiz "numeros.csv"
	buffer: .space 5
	array: .space 40000
	title: .asciiz "AOC1 - Trabalho 1\n"
	description: .asciiz "Ler numeros de um arquivo, ordena-los e printa-los.\n\n"
	error: .asciiz "Ih, deu caquinha em algum lugar... Boa sorte debugando!"

.text
	printStr(title) # Imprime titulo do programa
	printStr(description) # Imprime descricao do programa
	
	openFile(file) # Abre arquivo em modo de leitura
	slt $t0, $v0, $zero # O File Descriptor e menor que 0? (Retorna 1 se SIM, 0 se NAO)
	bne $t0, $zero, ERROR # Se o File Descriptor e menor que 0, fecha o programa
	add $s0, $v0, $zero # Salva o File Descriptor no $s0
	
	#jal strToInt
	
	closeFile($s0) # Fecha o arquivo

	endProgram()

ERROR:
	printStr(error)
	endProgram()


#strToInt