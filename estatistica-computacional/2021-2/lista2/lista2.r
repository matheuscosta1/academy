#Exercício 01

##Letra A

vectorA <- seq(from = 1, to = 20)
vectorA

##Letra B

vectorB <- seq(from = 20, to = 1)
vectorB

##Letra C
vectorC <- seq(from = 1, to = 20)
vectorC

vectorD <- seq(from = 19, to = 1)
vectorD

vectorUnificado <- append(vectorC, vectorD)
vectorUnificado

#Letra D

vetorD <- c(4,6,3)
vetorD <- rep(vetorD, 12)
vetorD

length(vetorD[vetorD==4])
length(vetorD[vetorD==6])
length(vetorD[vetorD==3])

#Letra E

vetorE <- c(4,6,3)
vetorE <- rep(vetorE, each = 1, len=37)
vetorE

length(vetorE[vetorE==4])
length(vetorE[vetorE==6])
length(vetorE[vetorE==3])

#Letra F

pontosX <- seq(from = 3, to = 6, by = 0.1)
vetorF <- exp(pontosX)*cos(pontosX)
vetorF

excosx = function(x) {
  exp(x)*cos(x)
}
res = excosx(seq(3, 6, 0.1))
res

#Exercício 02

#Letra A

i <- 10
result <- 0
for(i in 100){
  result <- (i^3) + (4*(i^2))
  print(result)
}
result

#Letra B

i <- 10
result <- 0
for(i in 25){
  result <- (2^i/i) + (3^i/i^2)
}
result


#Exercício 03

vetorX <- sample(0:999, 250, replace = TRUE)
vetorY <- sample(0:999, 250, replace = TRUE)

#Letra A

impar <- (!(vetorX %% 2) == 0)
vetorImpar <- vetorX[impar]

#Letra B

vetorB <- c()

b = vetorY[-1] - vetorX[-length(vetorX)]
b

for(i in 2:250){
  vetorB[i-1] <- vetorY[i] - vetorX[i-1]
}

vetorB

#Letra C

vetorC <- c()

for(i in 2:250){
  vetorC[i-1] <- sin(vetorY[i])/cos(vetorX[i-1])
}

vetorC

c = sin(vetorY[-1])/cos(vetorX[-length(vetorX)])
c

#Letra D

vetorD <- c()

for(i in 2:250){
  vetorD[i-1] <- vetorX[i-1] + 2*vetorX[i] - vetorX[i+1]
}

vetorD

d = c()
for(i in 1:(length(vetorX) - 2)) {
  d[i] = vetorX[i] + 2*vetorX[i + 1] - vetorX[i + 2]
}
d
#Exercício 04

#Letra A
indicesDeValoresMaioresQue600DoVetorY <- which(vetorY > 600)
indicesDeValoresMaioresQue600DoVetorY

#Letra B
valoresDoVetorYMaioresQue600 <- vetorY[indicesDeValoresMaioresQue600DoVetorY]
valoresDoVetorYMaioresQue600

#Letra C
valoresDoVetorXQueCorrespondemValoresMaioresQue600DoVetorY <- vetorX[indicesDeValoresMaioresQue600DoVetorY]
valoresDoVetorXQueCorrespondemValoresMaioresQue600DoVetorY


#Letra D

vetorD <- c()

for(i in 1:250){
  vetorD[i] <- abs(vetorX[i] - mean(vetorX))^(1/2)
}

vetorD

d = sqrt(abs(vetorX - mean(vetorX)))
d

#Letra E

valorMaximoY <- max(vetorY)
quantidade <- 0
for(i in 1:250){
  if((valorMaximoY - vetorY[i]) <= 200){
    quantidade <- quantidade + 1
  }
}

quantidade

e = sum(abs(vetorY - max(vetorY)) <= 200)
e
#Letra F

valoresParesVetorX <- which(vetorX %% 2 == 0)
valoresParesVetorX <- vetorX[valoresParesVetorX]
length(valoresParesVetorX)

f = sum(vetorX %% 2 == 0)
f
#Letra G

posicoesDe3Em3 <- seq(from = 1, to = length(vetorY), by = 3)
valoresDeYEmPosicaoDe3Em3 <- vetorY[posicoesDe3Em3]
valoresDeYEmPosicaoDe3Em3

vetorG = vetorY[seq(from = 1, to = length(vetorY), by = 3)]
vetorG

#Exercício 05

num.impar = function(vetor) {
  quantidade <- 0
  for(i in vetor){
    if(!(i %% 2 == 0)){
      quantidade <- quantidade + 1
    }
  }
  quantidade
}

vetor <- seq(from = 1, to = 100)
quantidadeNumerosImpares <- num.impar(vetor)
quantidadeNumerosImpares

num.impar2 = function(vetor) {
  indicesImpares <- which(!vetor %% 2 == 0)
  length(vetor[indicesImpares])
}

num.impar2 = function(v) {
  sum(v %% 2)
}

vetor <- seq(from = 1, to = 100)
quantidadeNumerosImpares <- num.impar2(vetor)
quantidadeNumerosImpares

#Exercício 06

fibonacci = function(numero) {
  fibonacciVetor <- c()
  fibonacciVetor[1] <- fibonacciVetor[2] <- 1
  
  for (i in 3:numero){
    fibonacciVetor[i] <- fibonacciVetor[i-2] + fibonacciVetor[i-1]
  }
  
  fibonacciVetor
}

fibonacci(6)

#Exercício 07

tamanho.seq = function(probabilidade_ser_cara) {
  
  #vetor (0,1) em que 0 representa cara e 1 coroa
  
  quantidade_caras <- 0
  
  repeat {
    lancamento <- sample(c(0,1), size=1, replace=TRUE, prob = c(probabilidade_ser_cara, 1-probabilidade_ser_cara)) #discutir com os meninos sobre essa questão
    if(lancamento) break
    quantidade_caras <- quantidade_caras + 1
  }
  quantidade_caras
}

tamanho.seq(0.5)

maiorSequencia <- 0
for(i in 100){
  quantidadeCarasExperimento <- tamanho.seq(0.5)
  if(quantidadeCarasExperimento > maiorSequencia) maiorSequencia <- quantidadeCarasExperimento
}
maiorSequencia

#Exercício 08

reproducao_coelhos = function(numero, k) {
  
  fibonacciVetor <- c()
  fibonacciVetor[1] <- fibonacciVetor[2] <- 1
  
  for (i in 3:numero){
    fibonacciVetor[i] <- fibonacciVetor[i-1] + fibonacciVetor[i-2]*k 
  }
  
  fibonacciVetor[numero]
}
reproducao_coelhos(5, 3)

#Exercício 09

#Letra A

library(stringr)
?str_detect
?str_replace

#Letra B

dna = function(sequencia){
  stringSplit <- strsplit(sequencia, "")[[1]]
  a <- length(stringSplit[str_detect(stringSplit, "A")])
  c <- length(stringSplit[str_detect(stringSplit, "C")])
  g <- length(stringSplit[str_detect(stringSplit, "G")])
  t <- length(stringSplit[str_detect(stringSplit, "T")])
  
  vetor <- c(a,c,g,t)
  vetor
}
dna("AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGGATT")

#Letra C

rna = function(sequenciaDNA){
  stringSplit <- strsplit(sequenciaDNA, "")[[1]]
  result <- str_replace(stringSplit, "T", "U")
  paste(result, collapse = "")
}

rna("AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGGATT")

#Exercício 10

library(dslabs)

#a)

media = mean(murders$population)
media

estadoMaisPopuloso = murders[murders$population == max(murders$population), ]$state
estadoMaisPopuloso

estadoMenosPopuloso = murders[murders$population == min(murders$population), ]$state
estadoMenosPopuloso

summary(murders)

#b)
rate = (murders$total/murders$population)*10000
murders$rate = rate
murders

#c)
murders[order(murders$rate), ]$state

#d)
inferior6 = murders[murders$rate < 0.06, ]$state
inferior6
superior5 = murders[murders$rate > 0.05, ]$state
superior5
