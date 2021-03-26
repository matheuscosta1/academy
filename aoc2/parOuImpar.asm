#parOuImpar.asm

#DESC: Programa que le um inteiro da entrada padrao e testa se ele é par ou impar e informa pro usuario

#DIA 15.03.2021

#------------------------------------------------------------------------------------------------------

.data
str1: .asciiz "Programa que testa a paridade de um numero lido do teclado \n"
str2: .asciiz "Digite um numero: \n"
str3: .asciiz "E par \n"
str4: .asciiz "E impar\n"

.text
		#imprimir na tela uma mensagem informando o propósito do programa
	
		la $a0, str1
		addi $v0, $zero,4
		syscall
	
		#ler um numero inteiro (pular o teste de adequacao da entrada)
	
		la $a0, str2
		addi $v0, $zero,4
		syscall
	
		addi $v0, $zero, 5
		syscall
		add $s7, $zero, $v0 #move o int lido para o registrador s7
	
		#testar se o numero lido e par ou impar
		addi $s0, $zero, 1 #(0b0000 0000 0000 0000 0000 0000 0000 0000 0001)
		and $t0, $s7, $s0 #int & 1
		beq $t0, $zero, PAR
IMPAR:          la $a0, str4
		addi $v0, $zero,4
		syscall
		j	SAI
PAR:          	la $a0, str3
		addi $v0, $zero,4
		syscall
	
		#informar ao usuario a paridade do numero lido
	
		#informa ao SO que o programa terminou sem erros (return 0)
SAI:		addi $v0, $zero, 10
		syscall