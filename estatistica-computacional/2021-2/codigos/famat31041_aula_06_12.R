#relembrando vetores
a <- c(34,67,89,100) #criando um vetor
a #imprimindo um vetor
a[3] #selecionando o elemento que está na terceira posição do vetor a
a[c(3)] #selecionando o elemento que está na terceira posição do vetor a
a[c(1,4)] #selecionando o elemento da primeira e quarta posições do vetor a
a[c(TRUE, FALSE, FALSE, TRUE)] #selecionando o elemento da primeira e quarta posições do vetor a a partir de um vetor lógico

b <- 4:89 #criando um vetor que começa em 4 e termina em 89 saltando de 1 em 1
b
length(b) #tamanho do vetor b, isto é, quantos elementos o vetor b possui

y <- seq(from = 4, to = 89, by = 3) #criando um vetor que começa em 4 e termina em 89 saltando de 3 em 3
y
length(y)
x <- seq(from = 4, to = 89, length.out = 100) #criando um vetor que começa em 4 e termina em 89 e que possuirá 100 elementos igualmente espaçados
x[seq(from = 2, to = 100, by =2)] #selecionando os elementos do vetor x que estão nas posições pares

#selecionando, a seguir, os elementos das posições pares de y
pares <- seq(from = 2, to = 28, by = 2)
y[pares]

#outro modo
pares <- (1:length(y))%%2 == 0
y[pares]
y[1:length(y)%%2 == 0]

#selecionando os elementos pares que estão nas duas primeiras posições de y
z <- y[y%%2 == 0]
z[c(1,2)]%%2 == 0
z[c(1,2)][z[c(1,2)]%%2 == 0]


#algumas funções aplicadas a vetores
v <- sample(3:500, size = 56, replace = TRUE)
v
length(v) #tamanho do vetor
max(v) #retorna o maior elemento do vetor
min(v) #retorna o menor elemento do vetor
sum(v) #retorna a soma dos elementos do vetor
sum(v)/length(v)
mean(v) #retorna a média dos elementos do vetor
var(v) #retorna a variância dos elementos do vetor
sqrt(var(v)) #sqrt retorna a raiz quadrada de um número
sd(v) #retorna o desvio padrão de um número


order(v) #retorna as posições dos elementos que deixam o vetor em ordem crescente
sort(v) #ordena os elementos do vetor de forma crescente
v[order(v)]
rank(v) #indica qual a posição na ordenação crescente de cada elemento do vetor 

#matrizes
A <- matrix(data = c(12, 23, 13, 14), ncol = 2, byrow = TRUE) #criando uma matriz
A
A[1,] #extraindo a primeira linha da matriz A
A[2,] #extraindo a segunda linha da matriz A
A[,1][1] #extraindo o primeiro elemento da primeira coluna de A
A[2,3] #extraindo o elemento da linha 2 e coluna 3
A[2,3] <- "w" #atribuindo outro valor para o elemento da linha 2 e coluna 3
A #como pode ser observado, matrizes só admitem elementos da mesma classe
t(A) #transposta de A
diag(A) #extraindo os elementos da diagonal de A

B <- diag(4) #criando uma matriz indentidade 4x4
B
det(A) #determinante de uma matriz
solve(A) #inversa de uma matriz

#função sample
?sample
set.seed(1814)
dado1 <- sample(1:6, size = 10000, replace = TRUE) #sorteando mil valores de uma dado honesto
dado1

dado2 <- sample(1:6, size = 10000, replace = TRUE)
dado2

soma <- dado1 + dado2 #experimento: lançar dois dados e registrar a soma das facez superiores; em seguida, realizar este experimento 1000 vezes.
soma

#qual a probabilidade da soma ser 12?
sum(soma == 12)/1000 #valor prático
1/36 #valor teórico