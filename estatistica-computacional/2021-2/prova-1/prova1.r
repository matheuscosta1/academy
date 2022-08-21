##Matheus José da Costa             11711BCC008

#Questão 01


chicago <- read.csv("chicago.csv")
chicago

#Letra A)

#Quantidade de mortes por doenças cardiovasculares no período do estudo (1997-2000)

length(chicago$cvd)

#Estação que ocorreu mais mortes provocadas por doençás cardiovasculares

maximo_mortes_por_doenca_cardiovascular <- max(chicago$cvd)
maximo_mortes_por_doenca_cardiovascular

chicago$cvd == maximo_mortes_por_doenca_cardiovascular  
chicago[chicago$cvd == maximo_mortes_por_doenca_cardiovascular,]$season #Aqui vemos que a estação que ocorreu mais mortes é a Winter e Summer


#Estação que ocorreu menos mortes provocadas por doençás cardiovasculares

minimo_mortes_por_doenca_cardiovascular <- min(chicago$cvd)
minimo_mortes_por_doenca_cardiovascular

chicago$cvd == minimo_mortes_por_doenca_cardiovascular 
chicago[chicago$cvd == minimo_mortes_por_doenca_cardiovascular,]$season  #Aqui vemos que a estação que ocorreu menor ocorreu mortes é a Summer


#Letra B
max_mortes_doencas_respiratorias <- max(chicago$resp)
max_mortes_doencas_respiratorias
chicago[chicago$resp == max_mortes_doencas_respiratorias,]$year #Percebemos que todas as doenças respiratórias ocorreram no ano 2000.

#Letra C

#Média de temperatura em cada uma das 4 estações:

mean(chicago[chicago$season == "Winter",]$temp)
mean(chicago[chicago$season == "Spring",]$temp)
mean(chicago[chicago$season == "Summer",]$temp)
mean(chicago[chicago$season == "Autumn",]$temp)

#Média de umidade relativa em cada uma das 4 estações:

mean(chicago[chicago$season == "Winter",]$rhum, na.rm = TRUE)
mean(chicago[chicago$season == "Spring",]$rhum, na.rm = TRUE)
mean(chicago[chicago$season == "Summer",]$rhum, na.rm = TRUE)
mean(chicago[chicago$season == "Autumn",]$rhum, na.rm = TRUE)

boxplot(chicago[chicago$season == "Winter",]$temp, chicago[chicago$season == "Spring",]$temp, chicago[chicago$season == "Summer",]$temp,chicago[chicago$season == "Autumn",]$temp, names = c("Winter", "Spring", "Summer", "Autumn"))


#Letra D

winter <- chicago[chicago$season == "Winter",]
spring <- chicago[chicago$season == "Spring",]
summer <- chicago[chicago$season == "Summer",]
autumn <- chicago[chicago$season == "Autumn", ]

plot(x = chicago$time, y = chicago$temp, )

plot(chicago$time, y = chicago$temp, type = "n", xlab = "Time", ylab = "Temp")
points(winter$time, winter$temp, pch = 16, col = "red")
points(spring$time, spring$temp, pch = 16, col = "blue")
points(summer$time, summer$temp, pch = 16, col = "green")
points(autumn$time, autumn$temp, pch = 16, col = "yellow")


#Questão 02

#Letra A

baralho <- rep(c("AZUL", "VERMELHA", "AMARELA", "VERDE"), times=c(13,13,13,13))
baralho

jogos <- c()

for (i in 1:100000) {
  quantidade_cartas_verdes <- 0
  iterador <- 1
  repeat{
    if(quantidade_cartas_verdes == 2){
      jogos[i] <- "Sucesso"
    }else {
      jogos[i] <- "Fracasso"
    }
      
    if(iterador == 3){
      break
    }
    
    retirada <- sample(baralho, size = 1, replace = FALSE)
    
    if(retirada == "VERDE"){
      quantidade_cartas_verdes <- quantidade_cartas_verdes + 1
    }
    iterador = iterador + 1 
  }
}

estimativa_media_monte_carlo_sucessos <- mean(jogos == "Sucesso")
estimativa_media_monte_carlo_sucessos


#Letra B

baralho <- rep(c(1:13, 1:13, 1:13, 1:13))
baralho

jogos <- c()

for (i in 1:100000) {
  iterador <- 1
  repeat{

    retirada <- sample(baralho, size = 1, replace = FALSE)
    
    if(iterador == 3){
      if(retirada == 8){
        jogos[i] <- "Sucesso"
      }else {
        jogos[i] <- "Fracasso"
      }
      break
    }
    
    iterador = iterador + 1 
  }
}

estimativa_media_monte_carlo_sucessos <- mean(jogos == "Sucesso")
estimativa_media_monte_carlo_sucessos


#Letra C

baralho <- rep(c(1:13, 1:13, 1:13, 1:13))
baralho

jogos <- c()

for (i in 1:100000) {
  iterador <- 1
  carta1 <- 0
  carta2 <- 0
  carta3 <- 0
  repeat{
    
    retirada <- sample(baralho, size = 1, replace = FALSE)
    
    if(iterador == 1){
      carta1 <- retirada
    }
    else if(iterador == 2){
      carta2 <- retirada
    }
    else if (iterador == 3){
      carta3 <- retirada
      if(carta1 == carta2 && carta2 == carta3) {
        jogos[i] <- "Sucesso"
      }
      else {
        jogos[i] <- "Fracasso"
      }
      break
    }
    
    iterador = iterador + 1 
  }
}

estimativa_media_monte_carlo_sucessos <- mean(jogos == "Sucesso")
estimativa_media_monte_carlo_sucessos


#Letra D

baralho <- rep(c("AZUL", "VERMELHA", "AMARELA", "VERDE"), times=c(13,13,13,13))
baralho

jogos <- c()

for (i in 1:100000) {
  iterador <- 1
  carta1 <- ""
  carta2 <- ""
  carta3 <- ""
  repeat{
    
    retirada <- sample(baralho, size = 1, replace = FALSE)
    
    if(iterador == 1){
      carta1 <- retirada
    }
    else if(iterador == 2){
      carta2 <- retirada
    }
    else if (iterador == 3){
      carta3 <- retirada
      if(carta1 == "VERMELHA" && carta2 == "VERMELHA") {
        jogos[i] <- "Sucesso"
      }
      else {
        jogos[i] <- "Fracasso"
      }
      break
    }
    
    iterador = iterador + 1 
  }
}

estimativa_media_monte_carlo_sucessos <- mean(jogos == "Sucesso")
estimativa_media_monte_carlo_sucessos
