#Matheus José da Costa  11711BCC008

#Questão 01

#Letra A

gerador = function(numeroBolas){
  
  vetorAleatorio <- runif(numeroBolas)
  vetorASerPreenchido <- c()
  
  for(i in 1:numeroBolas){
    if(vetorAleatorio[i] < 2/21) {
      vetorASerPreenchido[i] <- "vermelha"
    }else if(vetorAleatorio[i] < 3/21) {
      vetorASerPreenchido[i] <- "amarela"
    }else if(vetorAleatorio[i] < 4/21) {
      vetorASerPreenchido[i] <- "verde"
    }else if(vetorAleatorio[i] < 5/21) {
      vetorASerPreenchido[i] <- "azul"
    } else {
      vetorASerPreenchido[i] <- "preta"
    }
  }
  
  return(vetorASerPreenchido)
}

gerador(21)

#Letra B

bolas <- c()
resultado = c()
for(i in 1:100000) {
  j = 0
  repeat{
    
    bolas[j] <- gerador(1)
    
    if("amarela" %in% bolas && "vermelha" %in% bolas) {
      break
    }
    
    j <- j+1
    resultado <- length(bolas)
  }
}

mean(resultado)

#Questão 02

#Letra A

pinguins <- read.csv("pinguim.csv", header =  TRUE)
as.factor(pinguins$species)
pinguinsMacho <- pinguins[pinguins$sex == "MALE",] 
pinguinsMacho

pinguinsFemea <- pinguins[pinguins$sex == "FEMALE",] 
pinguinsFemea

#Letra B
summary(pinguinsMacho)
pinguinsMacho

pinguinsMachoNormalizado <- scale(pinguins[,3:6])
pinguinsMachoNormalizado

matriz_distancia <- dist(pinguinsMachoNormalizado)
matriz_distancia
modelo <- hclust(d = matriz_distancia, method = "ward.D")
plot(modelo, labels = pinguins$species)


#Letra C

abline(h = 4, col= "red")
rect.hclust(modelo, k=4)

aglomerados <- cutree(modelo, k=4)
aglomerados

aglomerado1 <- pinguins[aglomerados == 1,]$species
aglomerado1

aglomerado2 <- pinguins[aglomerados == 2,]$species
aglomerado2

aglomerado3 <- pinguins[aglomerados == 3,]$species
aglomerado3

aglomerado4 <- pinguins[aglomerados == 4,]$species
aglomerado4

#Eu cortaria o dendograma em h = 4, gerou 4 aglomerados. Faria esse corte porque há uma grande similaridade de espécie dentro desses 4 aglomerados. Por razão da localidade, tamanho da asa, peso em gramas, tamanho da crista, profundidade da crista e afins...

#Letra D

femeas <- read.csv("treino.csv", header =  TRUE)
teste <- read.csv("teste.csv", header =  TRUE)

treino <- femeas[1:n,]
treino

arvore <- rpart(formula = treino, data = treino)
rpart.plot(arvore)

#Letra E

