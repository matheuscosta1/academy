vetor1 <- c(1,2,3)

vetor6 <- c(32:199)

vetor7 <- seq(from = 1, to = 76, length.out = 100)

numeros <- rnorm(n=1000, mean = 0, sd = 1)

sum(numeros < 0.5)

dado <- sample(1:6, size=70000, replace=TRUE)
deu6 = dado == 6
sum(deu6)/70000

dado1 <- sample(1:6, size=70000, replace=TRUE)
dado2 <- sample(1:6, size=70000, replace=TRUE)
soma = dado1 + dado2

2^c(1,2)

mean(vetor1)
median(vetor6)
min(vetor1)
max(vetor1)
sd(vetor1) #desvio padrao
var(vetor1)#variancia
sqrt(var(vetor1))
sort(vetor6, decreasing = TRUE)

a <- sample(1:10, size=30, replace = TRUE)
unique(a)
duplicated(a)

if(sum(duplicated(a)>0)){ 
  print("há repeticoes")
} else {  
  print("não há repetições")
}

soma <- 0
for(i in c(1,3,5)) {
  soma <- soma + i
}
soma

soma <- function(x,y){
  a <- x+y
  return(a)
}
soma(2,3)

#qual a probabilidade de que ao menos duas pessoas façam aniversario no mesmo dia?
#P(A) = 1 - P(A^c)
#P(A^c) = 365 * 364 * 363 * ... * 356 (numero_pessoas) / 365 ^ numero_pessoas

teorico <- 1 - prod(365:356)/365**10

a <- sample(1:365, size=10, replace = TRUE)
sum(duplicated(a))

contador <- 0
for(i in 1:100000){
  aniversarios = sample(1:365, size=10, replace = TRUE)
  if(sum(duplicated(aniversarios))>0){
    contador <- contador + 1
  }
}
experimental = contador/100000
experimental

abs(teorico - experimental)

estimativa_aniversario <- function(n){
  contador <- 0
  for(i in 1:100000){
    aniversarios = sample(1:365, size=n, replace = TRUE)
    if(sum(duplicated(aniversarios))>0){
      contador <- contador + 1
    }
  }
  contador
  return(contador/100000)
}

estimativa_aniversario(30)

x <- c()
for(j in 10:60){
  x[j-9] <- estimativa_aniversario(j) 
}
plot(10:60, x, type = "p", pch = 16)
abline(h=0.5, col = "blue")