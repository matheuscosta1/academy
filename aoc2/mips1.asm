.data

.text

main: 
	#int x;
	
	addi $s2, $zero, 42 #x = 42 --> coloca constante num registrador, inicializa a variável
	
	#x = 42, y=12, x=y
	add $s2, $zero, $s1
	
	
	add $s2, $s2, $s1
	sub $s2, $s2, $s1
	
	addi $s2, $zero, 42 #inicializa registradores
	addi $s1, $zero, 5
	
	div $s2, $s1 # pra onde vai esse resultado?
	
	mflo $s3 #pega o quociente da divisão dos registradores
	mfhi $s4 #pega o resto da divisão dos registradores
	
	addi $s2, $zero, 0x7fffffff #inicializa registradores
	addi $s1, $zero, 0x7fffffff
	
	mult $s2, $s1