.data
	tam:	.word 10
	v:		6, 4, 5, 1, 8, 7, 9, 2, 3, 10
	str1:	.asciiz "Programa a ser interpretado\n"
	strc:	.asciiz ","
.text
	
		li		$v0, 4
		la		$a0, str1
		syscall
	
		la		$a0, v		
	
		la		$s7, tam
		lw		$s7, 0($s7)
	
		addi	$a1, $s7, -1 
		jal		FUNC1

	
		la		$s6, v				
		add		$s0, $zero, $zero 	
FOR1:	slt		$t0, $s0, $s7		
		beq		$t0, $zero, SAI1
		#-----------
		li		$v0, 4
		la		$a0, strc
		syscall
		
		li		$v0, 1			
		lw		$a0, 0($s6)		
		syscall 	 	
		addi	$s6, $s6, 4 	 	 	 	
		#-----------
		addi	$s0, $s0, 1			
		j		FOR1
SAI1:	
		li		$v0, 10				
		syscall		 	 	 	 			 	 	 	 	


FUNC1:
		sw		$ra,   0($sp)
		sw		$a0,  -4($sp)
		sw		$a1,  -8($sp)
		sw		$s0, -12($sp)
		sw		$s7, -16($sp)
		sw		$s6, -20($sp)
		addi	$sp, $sp, -24		
		#-----------------				
		add		$s6, $zero, $a1		
		
		slti	$t0, $s6, 1
		bne		$t0, $zero, EXIT1		
		
		add		$s7, $zero, $a0		
		

		add		$s0, $zero, $zero		
FOR2:	slt		$t0, $s0, $s6
		beq		$t0, $zero, SAI2
		lw		$t1, 0($s7)		
		lw		$t2, 4($s7)		
		slt		$t3, $t1, $t2
		bne		$t3, $zero, SAI_IF1
		
		add		$a0, $zero, $s7		
		addi	$a1, $s7, 4			
		jal		FUNC2
			
		#------------
SAI_IF1:addi	$s7, $s7, 4
		addi	$s0, $s0, 1
		j		FOR2		
SAI2:	
		la		$s7, v							
		add		$a0, $zero, $s7
		addi	$a1, $s6, -1
		jal		FUNC1
		

EXIT1:	addi	$sp, $sp, 24		
		lw		$ra,  0($sp)
		lw		$a0, -4($sp)
		lw		$a1, -8($sp)
		lw		$s0, -12($sp)
		lw		$s7, -16($sp)
		lw		$s6, -20($sp)
		#-----------------
		jr		$ra								

FUNC2:
		sw		$ra,   0($sp)
		sw		$a0,  -4($sp)
		sw		$a1,  -8($sp)	
		addi	$sp, $sp, -12		
		#-----------------	

		lw		$t0, 0($a0)		
		
                lw		$t1, 0($a1)		
		sw		$t1, 0($a0)

		sw		$t0, 0($a1)
		addi	$sp, $sp, 12		
		lw		$ra,  0($sp)
		lw		$a0, -4($sp)
		lw		$a1, -8($sp)
		#----------
		jr		$ra