#dicasT1.asm
#
#
#
#---------------------------------------------------------------------


.data 
	fileIn: 	.asciiz 	"numeros.csv"
	buf:		.space 		5
	ch:		.string 
		
.text

	#abrir arquivo para leitura
	li	$v0, 13
	la	$a0, fileIn
	li	$a1, 0
	li	$a2, 0
	syscall
	
	#file descriptor no s7
	add 	$s7, $v0, $zero
	
	#le um char do arquivo
	li 	$v0, 14
	add 	$a0, $zero, $s7
	la	$a1, ch
	