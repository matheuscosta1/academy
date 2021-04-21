.data
  	vet:	.word	1, 6, 8, 10, 3, 9, 2, 7, 5, 4, 34, 20, 33
  	strc:	.asciiz	","

.text
	
	# teste quicksort
	addi	$s0, $zero, 13		#tam
	
  	la	$a0, vet
	add	$a1, $zero, $zero
	addi	$a2, $s0, -1
	
	jal	quicksort
	
	add	$s1, $zero, $zero
  	la	$s2, vet
	
WHILE_MAIN:	
  	slt	$t0, $s1, $s0
	beq	$t0, $zero, SAI_MAIN
	
	la	$a0, strc
	li	$v0, 4
	syscall
	
	lw	$a0, 0($s2)
	li	$v0, 1
	syscall
	
	addi	$s1, $s1, 1
	addi	$s2, $s2, 4
	
	j	WHILE_MAIN		
SAI_MAIN:

	# termina o programa
	li	$v0, 10
	syscall
  
# funcao quicksort	
quicksort:
	#a0 - &v
	#a1 - iniVet
	#a2 - fimVet
	
	#salva o contexto na pilha
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
	#--------------------------
	# copias do iniVet e fimVet
	add	$s6, $zero, $a1		# s6 <- iniVet
	add	$s7, $zero, $a2		# s7 <- fimVet
	
	
	add	$s0, $zero, $s6		# s0 <- i (iniVet)
	add	$s1, $zero, $s7		# s1 <- j (fimVet)
	
	addi	$t0, $zero, 4
	mul	$t1, $t0, $s6
	add	$s2, $a0, $t1		# s2 <- &v[i] (iniVet)
	
	mul	$t2, $t0, $s7
	add	$s3, $a0, $t2		# s3 <- &v[j] (fimVet)
	
	add	$t0, $s6, $s7
	addi	$t1, $zero, 2
	div	$t0, $t1
	mflo	$t2
	addi	$t0, $zero, 4
	mul	$t1, $t0, $t2
	add	$t3, $a0, $t1		
	lw	$s4, 0($t3)		# s4 <- pivo (v[(IniVet + FimVet) div 2])
	
WHILE1:	
  	sle	$t0, $s0, $s1		# while(i <= j)
	beq	$t0, $zero, SAI1
	# corpo while1 ------------
	
WHILE2:	
  	lw	$t0, 0($s2)		# while(v[i] < pivo)
	slt	$t1, $t0, $s4
	beq	$t1, $zero, SAI2
	
	addi	$s0, $s0, 1		# i <- i + 1
	addi	$s2, $s2, 4		# &v[i] ++
	
	j	WHILE2
SAI2:

WHILE3:	
  	lw	$t0, 0($s3)		# while(v[j] > pivo)
	sgt	$t1, $t0, $s4
	beq	$t1, $zero, SAI3
	
	addi	$s1, $s1, -1		# j <- j - 1
	addi	$s3, $s3, -4		# &v[j] --
	
	j	WHILE3
SAI3:

IF1:	
  	sle	$t0, $s0, $s1		# if(i <= j)
	beq	$t0, $zero, SAI4
	# corpo if ---------------
	# aux  <- v[i]
  	# v[i] <- v[j]
	# v[j] <- aux
	lw	$t0, 0($s2)
	lw	$t1, 0($s3)
	sw	$t1, 0($s2)
	sw	$t0, 0($s3)
	
	addi	$s0, $s0, 1		# i <- i + 1
	addi	$s2, $s2, 4		# &v[i]++
	addi	$s1, $s1, -1		# j <- j - 1
	addi	$s3, $s3, -4		# &v[j]--
	
	#-------------------------
SAI4:
	
	# fim while1 -------------
SAI1:	
IF2:	
  	slt	$t0, $s6, $s1		# if(iniVet < j)
	beq	$t0, $zero, SAI5
	
	add	$a1, $zero, $s6
	add	$a2, $zero, $s1
	
	jal	quicksort		# quicksort(v, iniVet, j)	
SAI5:
IF3:	
  	slt	$t0, $s0, $s7		# if(i < fimVet)
	beq	$t0, $zero, SAI6
	
	add	$a1, $zero, $s0
	add	$a2, $zero, $s7
	
	jal	quicksort		# quicksort(v, i, fimVet)
SAI6:	
	
	#restaura o contexto da pilha
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
