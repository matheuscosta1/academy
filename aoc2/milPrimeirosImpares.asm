#milPrimeirosImpares.asm

#DESC: ESCREVA um programa que some os mil primeiros numeros naturais impares

.data
	str1: 	.asciiz	"Programa que soma os 1000 primeiros inteiros ímpares\n"
	str2: 	.asciiz	"A soma dos 1000 primeiros impares é: "
	str3:	.asciiz "Não faço nada, eh soh pra demonstrar o uso da pilha"
	
	retFazAlgoMaravilhoso: .word
	
.text
	
	#imprime mensagem de propósito do programa
	la	$a0, str1
	li	$v0, 4
	syscall
	
	jal 	fazAlgoMaravilhoso
	add	$s0, $v0, $zero	#retorno da função
	
	#la	$t0, retFazAlgoMaravilhoso
	#la 	$v0, 0($t0)
	
	#chamar uma funcao que calcula a soma dos 1000 primeiros inteiros ímpares
	
	jal	milImpares
	add 	$s7, $v0, $zero #retorno da função em s7 (lugar seguro)
	
	#imprimir o resultado da soma
	
	la	$v0, str2
	li	$v0, 4
	syscall
	
	li	$v0, 1
	add	$v0, $s7, $zero
	
	#return 0
	li 	$v0, 10
	syscall

#--------------------------------------------


milImpares:

	#salvar o contexto na pilha
	
	sw	$ra, 0($sp)	#salva o endereco de retorno da funcao
	sw	$s0, -4($sp)
	sw	$s1, -8($sp)
	sw	$s2, -12($sp)
	sw	$s7, -16($sp)
	
	addi	$sp, $sp, -20	# ajusta o topo da pilha.. a pilha decresce em termo de endereço (só cresce pra trás)
	
	#-------------------------
	addi 	$s7, $s7, 1000	#numero de elementos a serem somados
	addi	$s1, $zero, 0	#acunulador
	addi	$s2, $zero, 1	# valor do próximo inteiro impar
	addi 	$s0, $zero, 0	#indice de iteração
	
FOR1:	slt	$t0, $s0, $s7
	beq	$t0, $zero, SAI1
	
	#-------------------------------
	
	add	$s1, $s1, $s2 	#acumula o valor do próximo inteiro ímpar
	addi 	$s2,  $s2, 2	#próximo inteiro impar
	
	#------------------------------
	
	
	addi 	$s0, $s0, 1
	j 	FOR1
	
SAI1: 	jal	verifica
	add	 $v0, $zero, $s1
	
	
	#salvar o contexto da pilha
	addi	$sp, $sp, 20 # ajusta o topo da pilha.. a pilha decresce em termo de endereço (só cresce pra trás)
	
	lw	$ra, 0($sp)	#recupera o contexto
	lw	$s0, -4($sp)
	lw	$s1, -8($sp)
	lw	$s2, -12($sp)
	lw	$s7, -16($sp)
	
	#-------------------------
	jr	$ra
	
verifica:
	la	$a0, str3
	li	$v0, 4
	syscall
	