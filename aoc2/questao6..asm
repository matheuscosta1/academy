.data
  arr:	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0	
  sz:   .word 42
  str1: .asciiz "digite o prox. numero\n"
  str2: .asciiz "1a mensagem de texto "
  str3: .asciiz "\n 2a mensagem de texto "
  str4: .asciiz "\n 3a mensagem de texto "

  
.text

  la	$s0, sz		
  lw	$s0, 0($s0)
  
  la	$s1, arr		
  
  add	$s2, $zero, $zero	
  
LOOP:
  beq	$s0, $s2, LOOP_E	
  
  li 	$v0, 4			
  la	$a0, str1
  syscall
  
  li	$v0, 5				
  syscall

  sll	$t0, $s2, 2		
  add	$t0, $t0, $s1		   
  
  sw	$v0,0($t0)		  
  
  addi	$s2,$s2,1		
  j	LOOP	
LOOP_E:  
  
  add	$a0, $zero, $s0		
  add	$a1, $zero, $s1			

  jal	soma_E
  add	$s7, $zero, $v0
   	
  jal	maior_E
  add	$s6, $zero, $v0
  
  jal	menor_E
  add	$s5, $zero, $v0
  
 
  li	$v0, 4
  la	$a0, str2
  syscall
  li	$v0, 1
  add	$a0, $zero, $s7	
  syscall
 
  li	$v0, 4
  la	$a0, str3
  syscall
  li	$v0, 1
  add	$a0, $zero, $s6	
  syscall
  
  li	$v0, 4
  la	$a0, str4
  syscall
  li	$v0, 1
  add	$a0, $zero, $s5
  syscall
  
  li	$v0, 10			#return 0
  syscall

############################################################    
soma_E:

  addi	$sp, $sp, -20
  sw	$ra, 4 ($sp)
  sw	$s0, 8 ($sp)
  sw	$s1, 12($sp)
  sw	$a0, 16($sp)
  sw	$a1, 20($sp)
  
  add	$s0, $zero, $zero	
  add	$s1, $zero, $zero     
  
L1:
  beq	$s1, $a0, LE1

  sll	$t0, $s1, 2		
  add	$t0, $t0, $a1		
  lw	$t0, 0($t0)
  add	$s0, $s0, $t0
  
  addi	$s1,$s1,1
  j	L1
    
LE1:
  add	$v0, $zero, $s0  
  
  lw	$ra, 4 ($sp)
  lw	$s0, 8 ($sp)
  lw	$s1, 12($sp)
  lw	$a0, 16($sp)
  lw	$a1, 20($sp)

  addi	$sp, $sp, 20
  jr $ra
  
############################################################    
maior_E:
  addi	$sp, $sp, -20
  sw	$ra, 4 ($sp)
  sw	$s0, 8 ($sp)
  sw	$s1, 12($sp)
  sw	$a0, 16($sp)
  sw	$a1, 20($sp)
  
   lw	$s0, 0($a1)	   			

  addi	$s1, $zero, 1      
  
L2:
  beq	$s1, $a0, LE2

  sll	$t0, $s1, 2		
  add	$t0, $t0, $a1		  	
  lw	$t0, 0($t0)		
  
  slt   $t7, $t0,$s0		
  bne	$t7, $zero, NOTSMALLER	  
  add	$s0, $zero, $t0		
NOTSMALLER:

  addi	$s1,$s1,1
  j	L2
    
LE2:
  add	$v0, $zero, $s0  
  
  lw	$ra, 4 ($sp)
  lw	$s0, 8 ($sp)
  lw	$s1, 12($sp)
  lw	$a0, 16($sp)
  lw	$a1, 20($sp)

  addi	$sp, $sp, 20

  jr $ra

############################################################    
menor_E:
  addi	$sp, $sp, -20
  sw	$ra, 4 ($sp)
  sw	$s0, 8 ($sp)
  sw	$s1, 12($sp)
  sw	$a0, 16($sp)
  sw	$a1, 20($sp)
     
  
  lw	$s0, 0($a1)	   

  addi	$s1, $zero, 1       
  
L3:
  beq	$s1, $a0, LE3

  sll	$t0, $s1, 2		
  add	$t0, $t0, $a1		
  lw	$t0, 0($t0)		
  
  slt   $t7, $t0,$s0		
  beq	$t7, $zero, NOTSMALLER2	  
  add	$s0, $zero, $t0		
NOTSMALLER2:

  addi	$s1,$s1,1
  j	L3
    
LE3:
  add	$v0, $zero, $s0  
  
  lw	$ra, 4 ($sp)
  lw	$s0, 8 ($sp)
  lw	$s1, 12($sp)
  lw	$a0, 16($sp)
  lw	$a1, 20($sp)

  addi	$sp, $sp, 20
  
  jr $ra