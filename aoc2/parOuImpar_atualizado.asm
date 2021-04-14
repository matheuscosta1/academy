#parOuImpar.asm
#
#DESC: Programa que le um inteiro da entrada padrao, testa se ele e par ou impar e informa ao usuario.

#DAA 15.03.2021

#int main() {
#  ...
#  ...
#  ...
#  return 0;
#}
#----------------------------------------------------------------------------------------------------
.macro done
	li $v0,10
	syscall
.end_macro

.macro	leInteiro # valor lido em $v0
	li	$v0, 5
	syscall
.end_macro

.macro imprimeStr(%str)
	li	$v0, 4
	la	$a0, %str
	syscall
.end_macro

.macro imprimeInt(%num)
	li	 $v0, 1
	add  $a0, $zero, %num
	syscall
.end_macro

.data
str1: .asciiz "Programa que testa a paridade de um numero lido do teclado \n"
str2: .asciiz "Digite um numero: "
str3: .asciiz "O num. eh par\n"
str4: .asciiz "O num. eh impar "
.text


		#imprimir na tela uma mensagem informando o proposito do programa
		#printf("Programa que testa a paridade de um numero lido do teclado \n");
	
		imprimeStr(str1)
		#la		$a0, str1
		#addi	$v0, $zero, 4
		#syscall
	
		#ler um numero inteiro (pular o teste de adequacao da entrada)
		
		imprimeStr(str2)
		#la		$a0, str2
		#addi	$v0, $zero, 4
		#syscall
	
		addi	$v0, $zero, 5
		syscall
		add		$s7, $zero, $v0  #move o int lido para o reg s7
	
		#testar se o numero lido e par ou impar & informar ao usuario a paridade do numero lido  (1&X = X)
		addi	$s0, $zero, 1 #(0b0000 0000 0000 0000 0000 0000 0000 0001)
		and		$t0, $s7, $s0 # int & 1 
		beq		$t0, $zero, PAR
IMPAR:	#la		$a0, str4
		#addi	$v0, $zero, 4
		#syscall
		imprimeStr(str4)
		imprimeInt($s7)
		j		SAI
PAR:	#la		$a0, str3
		#addi	$v0, $zero, 4
		#syscall
		imprimeStr(str3)
		imprimeInt($s7)

	#informa ao SO que o programa terminou sem erros (return 0)
SAI:	#addi	$v0, $zero, 10
		#syscall
		done
	

