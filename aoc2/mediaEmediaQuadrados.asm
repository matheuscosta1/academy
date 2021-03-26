#mediaEmediaQuadrados.asm

#DESC: Escreva um programa que leia 10 inteiros do teclado e calcule a sua média, e a média de seus quadrados. Depois informa ambas as médias ao usuário

#DIA 15.03.2021

#------------------------------------------------------------------------------------------------------

.data

#int v[10]. //declaracao array

arr: 	.space 40
i:	0
constante: 10
str1: 	.asciiz "A media dos numeros eh: "
str2:	.asciiz "com resto igual a: "

#arr2: 0,1,2,3,4,5,6,7,8,9 #int v10[0,1,2,3,4,5,6,7,8,9]

.text

#ganhar acesso ao endereço da primeira posição de arr

	la	$s0, arr # coloca o endereço de arr no registrador s0
			
#ler 10 inteiros do teclado

#for (int i=0; i< 10; i++) {...}
	la	$t0, i
	lw	$s1, 0($t0) 	#S1 <- MEM(t0 + 0) --> mapeado pra variável i
	la	$t0, constante
	lw	$s2, 0($t0) 	#S1 <- MEM(t0 + 0) --> mapeado pra variável i
FOR1:	slt 	$t1, $s1, $s2	#seta se for menor que --> t1 = rd (resultado) recebe 1 se s1 for menor que s2 e caso contrário, 0, rs = s1, rt = s2
	beq	$t1, $zero SAI1
	#corpo do loop { ... }
	addi	$v0, $zero, 5 #lê um inteiro
	syscall
	
	#arr[i] <- inteiro lido
	sw	$v0, 0($s0) 
	
	addi 	$s0, $s0, 4 # vai pra próxima word
	
	#------------
	addi	$s1, $s1, 1 #i++
	j FOR1

SAI1:
	
#calcular a media dos 10 inteiros

	la 	$s0, arr	#&arr[0]

	add	$s7, $zero, $zero	#acumulador
	add	$s1, $zero, $zero	#i = 0
	
FOR2:	slt	$t1, $s1, $s2
	beq 	$t1, $s1, SAI2
	#corpo do for
	
	#acumulador = acumulador + arr[i]
	
	lw	$t3, 0($s0)
	
	add	$s7, $s7, $t3
	
	addi	$s0, $s0, 4
	
	#-------------
	
	addi	$s1, $s1, 1
	j	FOR2


SAI2: #calcular a média - acc / 10
	div	$s7, $s2
	
	#quociente no LO
	
	#resto no HI
	
	#reportar os resultados
	
	addi	$v0, $zero, 4
	la 	$a0, str1
	syscall
	
	addi 	$v0, $zero, 1
	mflo	$a0
	syscall
	
	
	addi	$v0, $zero, 4
	la 	$a0, str2
	syscall
	
	addi 	$v0, $zero, 1
	mfhi	$a0
	syscall
	
	
	
#elevar os 10 inteiros ao quadrado

	la	$s0, arr	 #endereco da primeira posicao do arr
	add	$s7,$zero, $zero # i = 0
	
FOR3:	slt	$t1, $s7, $s2	 # testa se i < 10
	beq	$t1, $zero, SAI3
	
	#corpo do for
	lw	$t2, 0($s0)	#le arr[i]
	mult	$t2, $t2	# faz arr[i] * arr[i]
	mflo	$t2		# le o resultado da multiplicacao e salva no temporario t2
	sw	$t2, 0($s0)	#salva o numero ao quadrado e volta no array
	
	addi $s0, $s0, 4
	#
	
	addi	$s7, $s7, 1
	j FOR3

#calcular a media dos quadrados



#return 0

	addi $v0, $zero, 10
	syscall
