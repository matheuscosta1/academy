## Integrantes:
## Matheus José da Costa          11711BCC008
## Luiz Fellipe Machado Tristão   12011BCC037
## Gustavo Melo do Carmo          11721BCC035

##Exercício 01

#a)
vetorA = c(1:20)
vetorAs

#b)
vetorB = c(20:1)
vetorB

#c)
vetorC = c(1:20, 19:1) 
vetorC

#d)
vetorD = rep(c(4,6,3), 12)
vetorD

length(vetorD[vetorD==4])
length(vetorD[vetorD==6])
length(vetorD[vetorD==3])

#e)
vetorE <- c(4,6,3)
vetorE <- rep(vetorE, each = 1, len=37)
vetorE

length(vetorE[vetorE==4])
length(vetorE[vetorE==6])
length(vetorE[vetorE==3])

#f)
excosx = function(x) {
  exp(x)*cos(x)
}
resultado <- excosx(seq(3, 6, 0.1))
resultado

##Exercício 02

#a)
i <- 10
result <- 0
for(i in 100){
  result <- (i^3) + (4*(i^2))
}
result

#b)
i <- 10
result <- 0
for(i in 25){
  result <- (2^i/i) + (3^i/i^2)
}
result

##Exercício 03

vetorX <- sample(0:999, 250, replace = TRUE)
vetorY <- sample(0:999, 250, replace = TRUE)

#a)
imparesVetorX = vetorX[vetorX %% 2 != 0]
imparesVetorX

#b)
vetorB = vetorY[-1] - vetorX[-length(vetorX)]
vetorB

#c)
vetorC = sin(vetorY[-1])/cos(vetorX[-length(vetorX)])
vetorC

#d)
vetorD = c()
for(i in 1:(length(vetorX) - 2)) {
  vetorD[i] = vetorX[i] + 2*vetorX[i + 1] - vetorX[i + 2]
}
vetorD

##Exercício 04

#a)
indicesDeValoresMaioresQue600DoVetorY <- which(vetorY > 600)
indicesDeValoresMaioresQue600DoVetorY


#b)
valoresDoVetorYMaioresQue600 <- vetorY[indicesDeValoresMaioresQue600DoVetorY]
valoresDoVetorYMaioresQue600

#c)
valoresDoVetorXQueCorrespondemValoresMaioresQue600DoVetorY <- vetorX[indicesDeValoresMaioresQue600DoVetorY]
valoresDoVetorXQueCorrespondemValoresMaioresQue600DoVetorY


#d)
resultado = sqrt(abs(vetorX - mean(vetorX)))
resultado

#e)
resultado = sum(abs(vetorY - max(vetorY)) <= 200)
resultado

#f)
valoresParesVetorX = sum(vetorX %% 2 == 0)
valoresParesVetorX

#g)

posicoesDe3Em3 <- seq(from = 1, to = length(vetorY), by = 3)
valoresDeYEmPosicaoDe3Em3 <- vetorY[posicoesDe3Em3]
valoresDeYEmPosicaoDe3Em3

##Exercício 05

num.impar = function(vetor) {
  imp = 0
  for(i in vetor) 
    imp = imp + (i %% 2)
  imp
}

vetor <- seq(from = 1, to = 100)
resultado = num.impar(vetor)
resultado

num.impar2 = function(vetor) {
  sum(vetor %% 2)
}

vetor <- seq(from = 1, to = 100)
resultado = num.impar2(vetor)
resultado

##Exercício 06

fibonacci = function(numero) {
  fibonacciVetor <- c()
  fibonacciVetor[1] <- fibonacciVetor[2] <- 1
  
  for (i in 3:numero){
    fibonacciVetor[i] <- fibonacciVetor[i-2] + fibonacciVetor[i-1]
  }
  
  fibonacciVetor
}

fibonacci(6)


##Exercício 07

tamanho.seq = function(probabilidade_de_ser_cara) {
  # 0 = cara, 1 = coroa
  caras = 0;
  repeat {
    jogada = sample(c(0, 1), size = 1, replace=TRUE, prob = c(probabilidade_de_ser_cara, 1 -  probabilidade_de_ser_cara))
    #jogada = sample(c(0, 1), size = 1, replace=TRUE, prob = c(1-probabilidade_de_ser_cara,  probabilidade_de_ser_cara)) ##Observação: ficamos em dúvida sobre os parâmetros da probabilidade. Então definimos que a probabilidade ser cara, ou seja, sair 0, é o parâmetro de probabilidade. E a probabilidade de ser ímpar, é 1 menos a probabilidade de ser cara. Porém ficamos em dúvida na ordem desse parâmetro "prob". Se cada posição desse vetor corresponde a mesma posição no vetor c(0,1) que definimos.
    if(jogada) break
    caras = caras + 1
  }
  caras
}

tamanho.seq(0.7)

maior = 0
for(i in 1:100) {
  jogadas = tamanho.seq(1/2)
  if(jogadas > maior)
    maior = jogadas
}
maior

##Exercício 08

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

#e
maiorTaxa = murders[order(murders$rate)[length(murders$rate)], ]$state
maiorTaxa
menorTaxa = murders[order(murders$rate)[1], ]$state
menorTaxa

#f 
south = murders[murders$region == "South", ]
south

meanSouth = mean(south$rate)
meanSouth

sdSouth = sd(south$rate)
sdSouth

northCentral = murders[murders$region == "North Central", ]
northCentral

meanNorthCentral = mean(northCentral$rate)
meanNorthCentral

sdNorthCentral = sd(northCentral$rate)
sdNorthCentral

west = murders[murders$region == "West", ]
west

meanWest = mean(west$rate)
meanWest

sdWest = sd(west$rate)
sdWest

northEast = murders[murders$region == "Northeast", ]
northEast

meanNortheast = mean(northEast$rate)
meanNortheast

sdNortheast = sd(northEast$rate)
sdNortheast

nomeReg = c("South", "North Central", "West", "Northeast")
nomeReg

taxasMax = c(max(south$rate), max(northCentral$rate), max(west$rate), max(northEast$rate))
taxasMax

taxasMin = c(min(south$rate), min(northCentral$rate), min(west$rate), min(northEast$rate))
taxasMin

regMaiorTax = nomeReg[taxasMax == max(taxasMax)]
regMaiorTax

regMenorTax = nomeReg[taxasMin == min(taxasMin)]
regMenorTax

#g
boxplot(south$rate, main = "South", ylim = c(min(rate), max(rate)))
boxplot(northCentral$rate, main = "North Central", ylim = c(min(rate), max(rate)))
boxplot(west$rate, main = "West", ylim = c(min(rate), max(rate)))
boxplot(northEast$rate, main = "Northeast", ylim = c(min(rate), max(rate)))
par(mfrow = c(1,4))

#Tomando como base o boxplot apresentado, a regiao SUL é a mais violenta quando comparada com as demais regiões.
