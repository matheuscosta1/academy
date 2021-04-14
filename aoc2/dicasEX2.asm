


.data
	arr:	.space 40		#	vetor de 10 words



.text

	
	la		$s7, arr
	#le os inteiros
FOR1:
		li	$v0, 5
		syscall
		
		sw	$v0, 0($s7)
		addi	$s7, $s7 ,4   #arr apontar para a prox posicao do array
		j FOR1
SAI1:

	la		$s7, arr
	addi	$s6, $s7, 36
FOR2:
	lw	$t0, ($s7)
	lw	$t1, ($s6)
	
	sw	$t1, ($s7)
	sw	$t0, ($s6)
	
	addi	$s7, $s7, 4
	addi	$s6, $s6, -4
	


	j FOR2
SAI2: