#programa para iterar um vetor e printar na tela


.data
arr:	.space 40 #vetor de 10 posições
i: 		0
constante: 	10
str1:	.asciiz "O valor da posicao X no vetor eh: \n"
quebraLinha: .asciiz "\n"
.text
	
	la 	$s0, arr			#coloca em s0 referência para primeira posicao do vetor arr
		
	
	la 	$t0,	i			#load var i no registrador t0
	lw 	$s1, 	0($t0)			#coloca no registrador s1 o conteúdo da primeira posição do vetor
	la 	$t0, 	constante
	lw 	$s2, 	0($t0)			#coloca no registrador s2 o conteúdo da constante 10
	
FOR1:	slt 	$t1, 	$s1, 	$s2
	beq	$t1, 	$zero, SAI1
	
	#corpo do for
	addi	$v0, 	$zero, 	5		#coloca em v0 o sinal 5 para ler um inteiro
	syscall
	
	sw	$v0, 	0($s0)			#salva o valor de v0 no arr[i]
	
	move 	$a0, 	$v0			#coloca o valor lido em a0 para ser impresso
	addi	$v0, 	$zero, 	1		#coloca em v0 o sinal 1 para imprimir um inteiro
	syscall					#chama o sistema para imprimir um inteiro
	
	addi	$s0, 	$s0, 	4		#aponta para o próximo endereço do array, para salvar na próxima iteração
	
	#############
	
	addi 	$s1, 	$s1, 	1 		#i++
	j	FOR1

SAI1:
#return resultado
	addi 	$v0, $zero, 10
	syscall
