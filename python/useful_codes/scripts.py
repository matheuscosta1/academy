'''
a=10
b='matheus'
print('O numero e %d' %a)
print('Meu nome e %s' %b)

c = str(a)+b
print('Segue a concatenacao da string com um numero: %s' %c)
d,e,f = 1,2,3 #consigo definir muitas variaveis separadas por virgulas
print('%d' %d)
print('%d' %e)
print('%d' %f)
d,e,f = 'OBA'
print('\n')
print('%s' %d)
print('%s' %e)
print('%s' %f)
n1 = int(input('Primeiro numero: '))
n2 = float(input('Segundo numero: '))
soma = n1+n2
print('Soma: %f'%soma)

a = str(2 **1000000)
b = len(a)
print('Numero de caracteres da cadeia e: %d' %b)    

a=int(input('Digite um numero: '))
if a%2==0 and a>=0:
    print("\nO numero %d e par e natural"%a)
elif not(a%2==0) and a>=0: 
    print("O numero %d e impar"%a)
else: print("Numero nao natural")    

a= raw_input("Entre com o nome de usuario: ")
b= int(input('Entre com a velocidade do seu veiculo: '))

if b>110: 
    d = (b-110)*5 
    print("Usuario %s foi multado em %d reais" %(a, d))
else: print("Usuario %s dentro dos padroes de velocidade" %a)

minutos = int(input("Minutos utilizados na linha: "))
if minutos < 200:
    preco = 0.20
else:
    if minutos <=400:
        preco = 0.18
    else: 
        preco = 0.15
print("Conta telefonica: R$%6.2f"%(minutos*preco))

x=0
while x <= 40:
    print("%d" %x)
    x=x+1
 
n=1
soma=0
while n<=10:
    x=int(input("Digite o %d numero: "%n))
    soma = soma+x
    n=n+1
print("Soma: %d"%soma)
media = soma/10
print("media: %f" %media)

x = int(input("Entre com um numero: "))
i=1
fat = 1
while i<=x:
    fat = fat*i
    i = i+1
print("Fat(%d) e: %d"%(x,fat))
soma=0
while True:
    x = int(input("Entre com um numero: "))
    if x==0: 
        break
    soma = soma+x
print("Soma: %d"%soma)

numero = int(input("Numero: "))
maximo=0    
while numero >= maximo:
    print('%d\t'%maximo)
    maximo=maximo+1

numero = int(input("Numero: "))
maximo=0
while numero >= maximo:
    if (maximo % 2 == 0):
        print('%d\t'%maximo)
    maximo=maximo+1

tabuada=1
while tabuada <= 10:
    numero=1
    print("Tabuada do %d\n" %tabuada)
    while numero <= 10:
      print("%d*%d=%d\n"%(tabuada,numero,tabuada))    
      numero = numero + 1
    tabuada = tabuada + 1

i=0
numero = []

while i < 3:
    numero.append(input("Numero: "))
    if i == 2:
        j=0
        if numero[j] >= numero[j+1] and numero[j] >= numero[j+2]:
            print("O numero %d e o maior"%numero[j])
        else:
            if numero[j+1] >= numero[j+2]:
                print("O numero %d e o maior"%numero[j+1])
            else:
                print("O numero %d e o maior"%numero[j+2])
    i=i+1

numero = int(input("Escolha um numero de letras para serem lidas: "))
consoantes = []
i=0
while i < numero:
    consoantes.append(raw_input("Entre com uma letra: "))
    if i == numero-1:
        j=0
        cont=0
        while j < numero:
            if consoantes[j] not in 'aeiou':
                cont += 1
            j+=1
    i+=1
print("Numero de consoantes: %d"%cont)
palavra = raw_input ('Palavra: ')
if palavra == palavra [::-1]:
    print("%s e uma palavra palindrome"%palavra)
else:
    print("%s nao e uma palavra palindrome"%palavra)

palavra = raw_input("Palavra: ")
k=0
troca=""
while k < len(palavra):
    if palavra[k] in "aeiou":
        troca = troca + "*"
    else:
        troca = troca + palavra[k]
    k+=1
print("Nova palavra com asteriscos resolvidos: %s"%troca)

print(troca.split())
print(troca.find('*'))

dia, mes, ano = raw_input("Entre com a sua data de nascimento (Dia/Mes/Ano): ").split('/')

data = ['jan','fev','marc','abril','maio','jun','ago','sept','oct','nov','dezem']
print("You bornt in this date:")
print("%s/%s/%s"%(dia,data[int(mes)-1],ano))

def par (x):
    return x%2==0
print(par(2))    

def fat (x):
    i=1
    fatorial=1
    while i <= x:
        fatorial = i*fatorial
        i+=1
    return fatorial
print(fat(5))    

for i in range(5): 
    print("Fat %d:\t%d"%(i,fat(i)))
'''
def embaralha(s):
    import random
    lista = list (s)
    random.shuffle(lista)
    return ''.join(lista)
print(embaralha('matheus')) 
    
#random.r
