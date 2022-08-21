##Revisão Prova 02 

#Questão 01

#Letra A
  
inversa <- function(y){
  return (-50*log(1-y))
}

u <- runif(1)
inversa(u)

geradora <- function(n){
  u <- runif(n)
  return (inversa(u))
}

geradora(10000)
mean(geradora(1000000))

#Letra B - Monte Carlo
resultados <- geradora(100000)
mean(resultados > 6)

#Letra C

numerador <- mean(resultados > 18)
denominador <- mean(resultados > 12)
numerador/denominador

#Questão 02

#P(X = i) = 1/6, i = 1,2,3,4,...,6


vetor_probabilidades <- rep(1, times = 6)/6
vetor_probabilidades

intervalos <- cumsum(vetor_probabilidades)
intervalos

#letra A

gerador <- function (n){
  x <- c()
  u <- runif(n)
  
  for(j in 1:n){
    if(u[j] <= intervalos[1]){
      x[j] <- 1
    }else if(u[j] <= intervalos[2]){
      x[j] <- 2
    }else if(u[j] <= intervalos[3]){
      x[j] <- 3  
    }else if(u[j] <= intervalos[4]){
      x[j] <- 4
    }else if(u[j] <= intervalos[5]){
      x[j] <- 5
    }else {
      x[j] <- 6
    }
  }
  return(x)
}
gerador(10000)
mean(gerador(100000) == 2)
1/6

#letra B

y <- c()
for(k in 1:100000){
  fracasso <- 0
  valores <- c()
  
  repeat{
    x <- gerador(1)
    valores <- c(valores, x)
    
    if(x == 6){
      fracasso <- fracasso+1
    }
    if(fracasso == 2){
      break
    }
  }
  y[k] <- length(valores) - 2
}
y
mean(y)

######################################################################################3
#Lista 04 do semestre atual

#Questão 03

inversa <- function(y) {
  return((-1 + sqrt(1+8*y))/2)
}
inversa(runif(1))

####################################################################################
#Lista 05 do semestre atual

data(iris)
iris <- iris[sample(nrow(iris)),]
sample(10)
iris
n <- round(nrow(iris)*0.8)
n
treino <- iris[1:n,]
teste <- iris[(n+1):nrow(iris),]
str(teste)

tamanho_petala <- treino$Petal.Length 

sim <- treino[tamanho_petala <= 3.3, 5]
nao <- treino[tamanho_petala >= 3.3,5]
table(sim)
table(nao)

t <- sort(tamanho_petala)

medias <- c()
for(j in 1:119){
  medias[j] <- mean(t[j:(j+1)])
}
medias

k <- 1
gini <- c()

for(k in 1:119){
  separacao <- (treino$Petal.Length <= medias[k])
  sim <- treino[separacao,]$Species
  nao <- treino[!separacao,]$Species
}

resposta <- treino$Petal.Length <= 1.5
sim <- treino[resposta,]$Species
nao <- treino[!resposta,]$Species
sim
nao

proporcaoSetosa <- sum(sim == "setosa")
proporcaoVirginica <- sum(sim == "virginica")
proporcaoSetosa 
proporcaoVirginica

giniSim <- sum(proporcaoSetosa) / length(sim)*(1-proporcaoSetosa) / length(sim)+(proporcaoVirginica)/length(sim)*(1-proporcaoVirginica)/length(sim)
giniSim 
