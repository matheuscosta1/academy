#bublesort.asm
#
#
#ALG:

#(01)void swap(int *a, int *b){ 
#(02)    int temp = *a; 
#(03)    *a = *b; 
#(04)    *b = temp; 
#} 
#(05)void bubbleSort(int *v, int n){ 
#(06)    if (n < 1)return; 
# 
#(07)    for (int i=0; i<n; i++) 
#(08)        if (v[i] > v[i+1]) 
#(09)            swap(&v[i], &v[i+1]);  
#(10)    bubbleSort(v, n-1); 
#} 

#(11)int main(){
#(12)    int tam = 10;
#(13)	 int v[10] = {6, 4, 5, 1, 8, 7, 9, 2, 3, 10};
#(14)    bubbleSort(&v,tam-1);
#(15)    for(int i=0;i<tam;i++)printf("%d ",v[i]);
#(16)    return 0;
#}
#
#------------------------------------------------------------

.data
	tam:	.word 10
	v:		6, 4, 5, 1, 8, 7, 9, 2, 3, 10
	str1:	.asciiz "Programa exemplo para conversao do bublesort de C para MIPS ASM\n"
	strc:	.asciiz ","
.text
	
		li		$v0, 4
		la		$a0, str1
		syscall
	
		#(14)    bubbleSort(&v,tam-1);
		la		$a0, v		#arg1 <- &v equiv. v[] equiv v[0]
	
		la		$s7, tam
		lw		$s7, 0($s7)
	
		addi	$a1, $s7, -1 #arg2 <- tam - 1	
		jal		BUBLESORT

		#(15)    for(int i=0;i<tam;i++)printf("%d ",v[i]);
	
		la		$s6, v				#pontiro para a primeira pos. de v
		add		$s0, $zero, $zero 	# i = 0	
FOR1:	slt		$t0, $s0, $s7		# i < tam
		beq		$t0, $zero, SAI1
		#-----------
		li		$v0, 4
		la		$a0, strc
		syscall
		
		li		$v0, 1				#cod para impressao de inteiros
		lw		$a0, 0($s6)			#v[i] 	
		syscall 	 	
		#avancar o ponteiro um indice
		addi	$s6, $s6, 4 	 	 	 	
		#-----------
		addi	$s0, $s0, 1			#i++
		j		FOR1
SAI1:	#(16) return 0
		li		$v0, 10				#return 0
		syscall		 	 	 	 			 	 	 	 	

#(05)void bubbleSort(int *v, int n)		
BUBLESORT:
		#salvar o contexto
		sw		$ra,   0($sp)
		sw		$a0,  -4($sp)
		sw		$a1,  -8($sp)
		sw		$s0, -12($sp)
		sw		$s7, -16($sp)
		sw		$s6, -20($sp)
		addi	$sp, $sp, -24		
		#-----------------				
		add		$s6, $zero, $a1		# s6 <- a1 (tam do array)
		
		#(06)    if (n < 1)return;
		slti	$t0, $s6, 1
		bne		$t0, $zero, EXIT1		
		
		#criar uma copia para o ponteiro de v
		add		$s7, $zero, $a0		# s7 <- a0 (que eh o ponteiro para v[0])
		
		#(07)    for (int i=0; i<n; i++)
		add		$s0, $zero, $zero		# i = 0						
FOR2:	slt		$t0, $s0, $s6
		beq		$t0, $zero, SAI2
		#corpo do for
		#(08) if (v[i] > v[i+1])
		lw		$t1, 0($s7)		#t1 <- v[i]
		lw		$t2, 4($s7)		#t2 <- v[i+1]
		slt		$t3, $t1, $t2
		bne		$t3, $zero, SAI_IF1
		
		#(09) swap(&v[i], &v[i+1]);
		add		$a0, $zero, $s7		#a0 <- &v[i]
		addi	$a1, $s7, 4			#a1 <- &v[i+1]
		jal		SWAP
			
		#------------
SAI_IF1:addi	$s7, $s7, 4
		addi	$s0, $s0, 1
		j		FOR2		
SAI2:	#(10)    bubbleSort(v, n-1); 
		la		$s7, v							
		add		$a0, $zero, $s7
		addi	$a1, $s6, -1
		jal		BUBLESORT
		
		#restaurar o contexto
EXIT1:	addi	$sp, $sp, 24		
		lw		$ra,  0($sp)
		lw		$a0, -4($sp)
		lw		$a1, -8($sp)
		lw		$s0, -12($sp)
		lw		$s7, -16($sp)
		lw		$s6, -20($sp)
		#-----------------
		jr		$ra								

#(01)void swap(int *a, int *b)
SWAP:#salvar o contexto
		sw		$ra,   0($sp)
		sw		$a0,  -4($sp)
		sw		$a1,  -8($sp)	
		addi	$sp, $sp, -12		
		#-----------------	

		#(02)    int temp = *a; 
		lw		$t0, 0($a0)		#t0 contem o conteudo de *a
		#(03)    *a = *b; 
		lw		$t1, 0($a1)		#t1 contem o conteudo de *b
		sw		$t1, 0($a0)
		#(04)    *b = temp;
		sw		$t0, 0($a1)
		#restaurar o contexto
		addi	$sp, $sp, 12		
		lw		$ra,  0($sp)
		lw		$a0, -4($sp)
		lw		$a1, -8($sp)
		#----------
		jr		$ra

