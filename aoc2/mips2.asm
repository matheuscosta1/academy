.data

.text

main: 
	
	addi $s0, $zero, 0xffffffff 
	addi $s1, $zero, 0xffff7777
	
	and $s2, $s0, $s1
	