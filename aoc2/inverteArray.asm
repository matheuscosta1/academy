#inverteArray.asm
#
#2)Escreva um programa que leia um array de 10 posicoes e armazene seus valores na memória. 
#A seguir inverta os elementos do array. v[0]<-> v[9], v[1]<-> v[8] .... 
#Imprima o vetor invertido de maneira formatada  [a,b,c,d,e.....]
#
#
#------------------------------------------------------------------------------------------
#------------------------------------------------
#Macros uteis	
.macro msg1
	li	$v0, 4
	la	$a0, str1
	syscall
.end_macro

.macro msgcr
	li	$v0, 4
	la	$a0, strcr
	syscall
.end_macro

.data
	arr:	.space 40
	sz:		.word 10
	str1:	.asciiz	"Digite o prox. inteiro: "
	strcr:	.asciiz "\n"
	strop:  .asciiz "["
	strcl:  .asciiz "]"
	strcm:  .asciiz ","

.text
		#ler os 10 valores do teclado
		la	$a0, arr
		la	$at, sz
		lw	$a1, 0($at)		
		jal	leInteiros 
		
		#inverter o array
		la	$a0, arr
		la	$at, sz
		lw	$a1, 0($at)		
		jal inverteArray
				
		#imprimir o array
		la	$a0, arr
		la	$at, sz
		lw	$a1, 0($at)
		jal imprimeArray

		li	$v0, 10
		syscall
#------------------------
#void leInteiros(int *pv, int sz)
leInteiros:
	#a0 - ponteiro para o array
	#a1 - tamanho do array
	#salva o contexto na pilha
	sw		$ra, 0($sp)
	sw		$a0, -4($sp)
	sw		$a1, -8($sp)
	sw		$s0, -12($sp)
	addi	$sp, $sp, -16	
	#----------------------------	
		#copia o ponteiro do array para um registrador de trabalho
		add	$t7, $zero, $a0
		
		add 	$s0, $zero, $zero		# i = 0
FOR1:	slt		$t0, $s0, $a1
		beq		$t0, $zero, SAI1
		#corpo do for ----
		#msg de texto 1
		msg1
		#le inteiro
		li		$v0, 5
		syscall
		sw		$v0, 0($t7)
		addi	$t7, $t7, 4	#arr++
		
		#msg enter
		msgcr
		#-----------------
		addi	$s0, $s0, 1		# i++
		j		FOR1
SAI1:	#restaura o contexto da pilha
		addi	$sp, $sp, 16
		
		lw		$ra, 0($sp)
		lw		$a0, -4($sp)
		lw		$a1, -8($sp)
		lw		$s0, -12($sp)
			
		jr	$ra
#------------------------
#void inverteArray(int *pv, int sz)
inverteArray:
	#a0 - ponteiro para o array
	#a1 - tamanho do array
	#salva o contexto na pilha
	sw		$ra, 0($sp)
	sw		$a0, -4($sp)
	sw		$a1, -8($sp)
	sw		$s0, -12($sp)
	sw		$s1, -16($sp)
	sw		$s2, -20($sp)
	
	addi	$sp, $sp, -24	
	#----------------------------	
		#copia o ponteiro do array para um registrador de trabalho
		add	$t7, $zero, $a0
		sll	$t6, $a1, 2
		addi $t6, $t6, -4
		add	$t6, $t6, $t7
		 	 
		add	$s0, $zero, $zero # i = 0
		srl	$t0, $a1, 1
FOR2:	slt	$t1, $s0, $t0
		beq	$t1, $zero, SAI2
		#corpo do for
		lw	$s1, 0($t7)
		lw	$s2, 0($t6)
		
		sw	$s1, 0($t6)
		sw	$s2, 0($t7)
		
		addi	$t7, $t7, 4
		addi	$t6, $t6, -4				
		
		#------------
		addi $s0, $s0, 1
		j FOR2	

SAI2:   #restaura o contexto da pilha
		addi	$sp, $sp, 24
		
		lw		$ra, 0($sp)
		lw		$a0, -4($sp)
		lw		$a1, -8($sp)
		lw		$s0, -12($sp)
		lw		$s1, -16($sp)
		lw		$s2, -20($sp)
		
		jr	$ra
#------------------------
imprimeArray:				
		
		addi $t6, $a1, -1	
		add	$t7, $zero, $a0  #ponteiro para o array
		#imprime o [
		la	$a0, strop
		li	$v0, 4
		syscall
	
		add 	$s0, $zero, $zero		# i = 0
FOR3:	slt		$t0, $s0, $a1
		beq		$t0, $zero, SAI3
	
		#imprime o valor do array	
		lw		$a0, 0($t7)
		li		$v0, 1
		syscall										
		
		#imprimir a virgula
		beq		$s0, $t6, SAI3
		la		$a0, strcm
		li		$v0, 4
		syscall
		
		#avancar o ponteiro do array
		addi	$t7, $t7, 4
		
		addi	$s0, $s0, 1		# i++
		j		FOR3
SAI3:	#imprime o ]
		la	$a0, strcl
		li	$v0, 4
		syscall			
			
	jr	$ra
	

