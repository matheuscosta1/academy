#Estruturas comuns de controle e repeticao

#1)
#if(x < y)
#...
#else
#...

#2)
#while(x>y) ....

#3)
#do ... while (x != y)

#---------------------------------------------------------
.macro imprimeStr(%str)
	li	$v0, 4
	la	$a0, %str
	syscall
.end_macro

.data
x: 		.word 142
y: 		.word 100	
str1:	.asciiz	"aqui eh o corpo do if"
str2:	.asciiz	"aqui eh o corpo do else"

.text
#Assuma que as variáveis x e y foram mapeadas para os registradores s1 e s2 respectivamente.

la		$s1, x					#42
lw		$s1 0($s1) 
la		$s2, y					#100
lw		$s2 0($s2)

#Primeiro caso, IF-ELSE 

IF1:
slt		$t0, $s1, $s2		#se x<y t0 = 1. senao t0 = 0
beq		$t0, $zero, ELSE1
		imprimeStr(str1)
		
		j	SAI1
ELSE1:	imprimeStr(str2)
    
SAI1:    


#2)
#while(x>y)			equiv. y<x

WHILE2	slt		$t0, $s2, $s1
		beq		$t0, $zero, SAI2
		#---corpo do while



		#-----------------
		j WHILE2
SAI2:

#3)
#do ... while (x != y)

DO3:	#corpo do dowhile



		#----------------
		bne		$s1, $s2, DO3



#do ....
#
#i++;
#while(x < 10)
