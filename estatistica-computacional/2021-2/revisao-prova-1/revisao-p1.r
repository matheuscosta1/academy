#Matheus José da Costa
#11711BCC008

#Questao 1

#letra A
library(dslabs)
data(heights)

novoDataSet = heights
height_polegada <- heights[2]

height_centimetro <- (height_polegada*2.54)

novoDataSet["alt.m"] = height_centimetro
novoDataSet

#letra B

mean(novoDataSet$sex == "Male")


#letra C
#Maior Altura é de 210 centímetros, como pela função max. Essa altura é de um homem (Male)
max(novoDataSet$alt.m)
novoDataSet[1017,]

#letra D
#Usando a função min, conseguimos pegar o menor tamanho. Daí, há dois registros com essa altura, o de numero 1032 e o de numero 1045
min(novoDataSet$alt.m)
novoDataSet[1032,]
novoDataSet[1045,]

#letra E

media = mean(novoDataSet$alt.m)
media

desvioPadrao = sd(novoDataSet$alt.m)
desvioPadrao

#letra F
novoDataFrameHomens = subset(novoDataSet, novoDataSet$sex == "Male")
novoDataFrameHomens

mediaHomens = mean(novoDataFrameHomens$alt.m)
mediaHomens

desvioPadraoHomens = sd(novoDataFrameHomens$alt.m)
desvioPadraoHomens

novoDataFrameMulheres = subset(novoDataSet, novoDataSet$sex == "Female")
novoDataFrameMulheres

mediaMulheres = mean(novoDataFrameMulheres$alt.m)
mediaMulheres

desvioPadraoMulheres = sd(novoDataFrameMulheres$alt.m)
desvioPadraoMulheres

#Media na letra E deu 173.5405 e o desvio padrão deu 10.35969
#Calculando a média dos homens temos 176.0595 e desvio padrão 9.172
#Calculado a média das mulheres temos 164.9461 e desvio padrão 9.552067
#Num geral, as mulheres são menores que os homens

#letra G

par(mfrow = c(1,2))
boxplot(novoDataFrameHomens$alt.m, ylim = c(120,210))
boxplot(novoDataFrameMulheres$alt.m, ylim = c(120,210))

boxplot(novoDataFrameMulheres$alt.m, novoDataFrameHomens$alt.m, ylim = c(120,210), names = c("mulheres", "homens"))

#Pelo boxplot conseguimos ver que o desvio padrão das mulheres é maior que o dos homens e a média de tamanho dos homens é maior

#Questão 2

jogos <- c()

contador_juju <- 0
contador_jorel <- 0

for (i in 1:100000) {
    dinheiro_juju = 18
    dinheiro_jorel = 7
    repeat {
        if(dinheiro_juju == 0 || dinheiro_jorel == 0) {
          break
        }
      
        moeda <- c(0, 1)
        lancamento <- sample(0:1, size = 1)
      
        if(lancamento == 0){
          jogos[i] <- "Juju"
          dinheiro_jorel = dinheiro_jorel - 1
          dinheiro_juju = dinheiro_juju + 1
        }
        else{
          jogos[i] <- "Jorel"
          dinheiro_juju = dinheiro_juju - 1
          dinheiro_jorel = dinheiro_jorel + 1
        }
    }  
}

estimativa_juju_ganhar <- mean(jogos == "Juju")
juju_terminar_sem_dinheiro = 1 - estimativa_juju_ganhar
juju_terminar_sem_dinheiro

#Questão 3

#Letra A
gerador = function(numero){
  
  vetorAleatorio <- runif(numero, 0, 1)
  vetorASerPreenchido <- c()

  for(i in 1:numero){
    if(vetorAleatorio[i] < 1/6) {
        vetorASerPreenchido[i] <- 1
    }else if(vetorAleatorio[i] < 2/6) {
        vetorASerPreenchido[i] <- 2
    }else if(vetorAleatorio[i] < 3/6) {
        vetorASerPreenchido[i] <- 3
    }else if(vetorAleatorio[i] < 4/6) {
        vetorASerPreenchido[i] <- 4
    }else if(vetorAleatorio[i] < 5/6) {
        vetorASerPreenchido[i] <- 5
    }else {
        vetorASerPreenchido[i] <- 6
    }
  }

  return(vetorASerPreenchido)
}

#Letra B

valores <- c()
for (i in 1:100000) {
  fracasso <- 0
  repeat{
    if(fracasso == 2) {
      break
    }
    
    lancamento <- gerador(1)
    
    if(lancamento == 6){
      valores[i] <- "Fracasso"
      fracasso <- fracasso + 1
    } else {
      valores[i] <- "Sucesso"
    }
  }
}

estimativa_media_monte_carlo_sucessos <- mean(valores == "Sucesso")
estimativa_media_monte_carlo_sucessos



### ( 1/b-a * integral de a até b de g(x)dx ) é o mesmo que a média (g(x1) + ... + g(xn))/n * (b-a). Ou seja, a média*(b-a)
###
###
###

funcao_g <- function(x) {
    return (exp(2*x + x**2))
}

y <- runif(100000, 0, 2)
h <- funcao_g(y)

(2 - 0) * mean(h)

EstimativaIntegral <- function(a,b) {
  y <- runif(100000, a, b)
  h <- funcao_g(y)
  return ((b-a)*mean(h))
}

EstimativaIntegral(0,1)
EstimativaIntegral(-1,2)

alturas <- read.csv("heights.csv", header =  TRUE)
alturas <- alturas[,-1] #exclui coluna 1 que não tem informação relevante
 
alturas$alt.cm <- alturas$height * 2.54
str(alturas)

mean(alturas$sex == "Male")

alt.max <- max(alturas$alt.cm)
alt.max

alturas$alt.cm == alt.max
alturas[alturas$alt.cm == alt.max,]
alturas[alturas$alt.cm == alt.max,1]

mean(alturas$alt.cm)
sd(alturas$alt.cm)

hist(alturas$alt.cm)

homens <- alturas[alturas$sex == "Male",-1]
homens

mulheres <- alturas[alturas$sex == "Female",-1]
mulheres

mean(homens$alt.cm)
sd(homens$alt.cm)

mean(mulheres$alt.cm)
sd(mulheres$alt.cm)

boxplot(homens$alt.cm)
boxplot(mulheres$alt.cm)

boxplot(homens$alt.cm, mulheres$alt.cm, names = c("mulheres", "homens"))
