# trabalho1.asm
# Alunos:
# 		Matheus José da Costa		11711BCC008
#		Leonardo Ferreira Essia 	11721BCC009
#Conversao ATOI dos numeros do arquivo pra um array e ordenação do array utilizando quicksort.

#Utils Leitura Arquivo
# $s0: Ponteiro para File Descriptor
# $s1: vetorInteiros
# $s2: vetorBuffer
# $s3: Conta caracteres lidos no vetorBuffer
# $s5: Status da leitura do arquivo
# $s6: virgula
# $s7: espacoBranco

.data
	vetorInteiros: .space 1000
	vetorBuffer: .space 6
	virgula: .asciiz ","
	espacoBranco: .asciiz " "
	barraN: .asciiz "\n"
	descricao: .asciiz "Conversao ATOI dos numeros do arquivo pra um array e ordenação do array utilizando quicksort.\n\n\n"
	error: .asciiz "Erro na leitura do arquivo."
	arquivo: .asciiz "numeros.csv"

.text

	la $a0, descricao
	li $v0, 4
	syscall
		
	la $a0, arquivo
	li $a1, 0
	li $a2, 0
	li $v0, 13
	syscall

	slt $t0, $v0, $zero
	bne $t0, $zero, FILE_ERROR
	add $s0, $v0, $zero

	la $s1, vetorInteiros

	la $t1, virgula
	lb $s6, 0($t1)
	la $t1, espacoBranco
	lb $s7, 0($t1)

######################################################################################################################################################
#LE ARQUIVO E CONVERTE STRING TO INT (ATOI)
######################################################################################################################################################	

READ_FILE:

	la $s2, vetorBuffer
	add $s3, $zero, $zero
DO_WHILE1:
	
	li $v0, 14
	add $a0, $zero, $s0
	add $a1, $zero, $s2
	li $a2, 1
	syscall
		
	slt $t0, $v0, $zero
	bne $t0, $zero, FILE_ERROR
	
	beq $v0, $zero, END_DO_WHILE1
	
	addi $s3, $s3, 1
	lb $t0, 0($s2)
	
	beq $t0, $s6, END_DO_WHILE1
	beq $t0, $s7, END_DO_WHILE1
	
	addi $s2, $s2, 1
	
	j DO_WHILE1
	
END_DO_WHILE1:
	add $s5, $zero, $v0 
	
	addi $s3, $s3, -1 
	beq $s3, $zero, JUMP_TO_QUICKSORT
	
	la $a0, vetorBuffer 
	add $a1, $zero, $s3
	
	jal atoi
	
	sw $v0, 0($s1) 
	addi $s1, $s1, -4
	
JUMP_TO_QUICKSORT:
	bne $s5, $zero, READ_FILE
		
	add $a0, $zero, $s0
	li $v0, 16
	syscall
	
	addi	$s0, $zero, 1000
	
  	la	$a0, ($s1)
	add	$a1, $zero, $zero
	addi	$a2, $s0, -1
	
	la	$s2, ($s1)
	
	jal	quicksortLabel
	
	add	$s1, $zero, $zero
	
  	
WHILE_MAIN:	
  	slt	$t0, $s1, $s0
	beq	$t0, $zero, END_MAIN
	
	la	$a0, virgula
	li	$v0, 4
	syscall
	
	lw	$a0, 0($s2)
	li	$v0, 1
	syscall
	
	addi	$s1, $s1, 1
	addi	$s2, $s2, 4
	
	j	WHILE_MAIN  	
  	
	li $v0, 10
	syscall

FILE_ERROR:
	la $a0, error
	li $v0, 4
	syscall

	li $v0, 10
	syscall
	
atoi:

	sw $ra, 0($sp)
	sw $s0, -4($sp)
	sw $s1, -8($sp)
	sw $s6, -12($sp)
	sw $s7, -16($sp)
	
	addi $sp, $sp, -20
	
	add $s0, $zero, $a0 
	add $s1, $zero, $a1 
	li $s6, 10
	li $s7, 0 
	
FOR_ATOI_LABEL1:
	slt $t0, $zero, $s1
	beq $t0, $zero, END_FOR_ATOI_LABEL1
		
	add $a0, $zero, $s6 
	addi $a1, $s1, -1 
	jal pow 
	
	lb $t1, 0($s0)
	addi $t1, $t1, -48
	mul $t3, $v0, $t1 
	add $s7, $s7, $t3 
	
	addi $s0, $s0, 1 
	addi $s1, $s1, -1
	j FOR_ATOI_LABEL1
	
END_FOR_ATOI_LABEL1:	
	add $v0, $zero, $s7

	addi $sp, $sp, 20
	lw $ra, 0($sp)
	lw $s0, -4($sp)
	lw $s1, -8($sp)
	lw $s6, -12($sp)
	lw $s7, -16($sp)
	
	jr $ra

pow:

	addi $sp, $sp, -16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $ra, 12($sp)


	add $s0, $zero, $a0 
	add $s1, $zero, $a1
	li $s2, 1 
	
FOR_POW:
	slt $t0, $zero, $s1
	beq $t0, $zero, END_FOR_POW
		
	mul $s2, $s2, $s0
	
	addi $s1, $s1, -1
	j FOR_POW
	
END_FOR_POW:
	add $v0, $zero, $s2

	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	
	jr $ra

######################################################################################################################################################
#QUICKSORT
######################################################################################################################################################
	
END_MAIN:

	li	$v0, 10
	syscall
  
quicksortLabel:
	
	sw	$ra,   0($sp)
	sw	$a1,  -4($sp)
	sw	$a2,  -8($sp)
	sw	$s0, -12($sp)
	sw	$s1, -16($sp)
	sw	$s2, -20($sp)
	sw	$s3, -24($sp)
	sw	$s4, -28($sp)
	sw	$s6, -32($sp)
	sw	$s7, -36($sp)
	
	addi	$sp, $sp, -40
	

	add	$s6, $zero, $a1		
	add	$s7, $zero, $a2		
	
	
	add	$s0, $zero, $s6		
	add	$s1, $zero, $s7		
	
	addi	$t0, $zero, 4
	mul	$t1, $t0, $s6
	add	$s2, $a0, $t1		
	
	mul	$t2, $t0, $s7
	add	$s3, $a0, $t2		
	
	add	$t0, $s6, $s7
	addi	$t1, $zero, 2
	div	$t0, $t1
	mflo	$t2
	addi	$t0, $zero, 4
	mul	$t1, $t0, $t2
	add	$t3, $a0, $t1		
	lw	$s4, 0($t3)		
	
WHILE_LABEL1:	
  	sle	$t0, $s0, $s1		
	beq	$t0, $zero, END_LABEL1
	
WHILE_LABEL2:	
  	lw	$t0, 0($s2)		
	slt	$t1, $t0, $s4
	beq	$t1, $zero, END_LABEL2
	
	addi	$s0, $s0, 1		
	addi	$s2, $s2, 4	
	
	j	WHILE_LABEL2
END_LABEL2:

WHILE_LABEL3:	
  	lw	$t0, 0($s3)		
	sgt	$t1, $t0, $s4
	beq	$t1, $zero, END_LABEL3
	
	addi	$s1, $s1, -1		
	addi	$s3, $s3, -4		
	
	j	WHILE_LABEL3
END_LABEL3:

IF_LABEL1:	
  	sle	$t0, $s0, $s1		
	beq	$t0, $zero, END_LABEL4

	lw	$t0, 0($s2)
	lw	$t1, 0($s3)
	sw	$t1, 0($s2)
	sw	$t0, 0($s3)
	
	addi	$s0, $s0, 1		
	addi	$s2, $s2, 4		
	addi	$s1, $s1, -1		
	addi	$s3, $s3, -4		
	
END_LABEL4:
	
END_LABEL1:

IF_LABEL2:	
  	slt	$t0, $s6, $s1		
	beq	$t0, $zero, END_LABEL5
	
	add	$a1, $zero, $s6
	add	$a2, $zero, $s1
	
	jal	quicksortLabel	
	
END_LABEL5:

IF_LABEL3:	
  	slt	$t0, $s0, $s7		
	beq	$t0, $zero, END_LABEL6
	
	add	$a1, $zero, $s0
	add	$a2, $zero, $s7
	
	jal	quicksortLabel	
	
END_LABEL6:	
	
	addi	$sp, $sp, 40
	
	lw	$ra,   0($sp)
	lw	$a1,  -4($sp)
	lw	$a2,  -8($sp)
	lw	$s0, -12($sp)
	lw	$s1, -16($sp)
	lw	$s2, -20($sp)
	lw	$s3, -24($sp)
	lw	$s4, -28($sp)
	lw	$s6, -32($sp)
	lw	$s7, -36($sp)
	
	jr	$ra
