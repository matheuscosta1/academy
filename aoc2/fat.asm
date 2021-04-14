#fat.asm
#
#
# int fat(int n){
# 	if(n == 0) || (n == 1)
#		return 1
#	else{
#		return n * fat(n-1);
#	}		  
#}
#-----------------------------------------------------------------------------

.data
	n:	.word
	str1: .asciiz "Programa que calcula recursivamente a fatorial de um numero\n"
	str2: .asciiz "Digite n: "
	str3: .asciiz "O fatorial de n eh: "
.text
	la		$a0, str1
	li		$v0, 4
	syscall
	
	la		$a0, str2
	li		$v0, 4
	syscall
	
	li		$v0, 5
	syscall

	add		$a0, $zero, $v0 #n
	jal		FAT
	add		$s0, $zero, $v0
	
	la		$a0, str3
	li		$v0, 4
	syscall
	
	li		$v0, 1
	add		$a0, $zero, $s0
	syscall
	
	li		$v0, 10
	syscall

FAT:#salvar o contexto
	sw	$ra, 0($sp)
	sw	$a0, -4($sp)
	sw	$s0, -8($sp)

	addi $sp, $sp, -12
	#--------------------
			
	#if(n == 0) || (n == 1) return 1
	addi $v0, $zero, 1  #return 1
	
	slti $t0, $a0, 2
	bne	 $t0, $zero, SAI1
RECURCAO:
	add	 $s0, $zero, $a0    # s0 <- n
	addi $a0, $a0, -1		
	jal	 FAT	
	mul  $v0, $v0, $s0		# n * fat(n-1) 

	#--------------------
	#restaurar o contexto
SAI1:
	addi $sp, $sp, 12

	lw	$ra, 0($sp)
	lw	$a0, -4($sp)
	lw	$s0, -8($sp)
	
	jr	$ra