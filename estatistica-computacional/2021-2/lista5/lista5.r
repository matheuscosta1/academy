##Lista 5
##Integrantes:
##Matheus José da Costa         11711BCC008
##Luiz Fellipe Machado Tristão  12011BCC037
##Gustavo Melo                  11721BCC035

##Questão 01

##Letra A
papagaios = read.csv("papagaio.txt", header = TRUE, sep = ",")
tail(papagaios)
head(papagaios)
str(papagaios)
summary(papagaios)

##Letra B

mean(papagaios[papagaios$especie == "corniculata",]$envergadura)
mean(papagaios[papagaios$especie == "cirrhata",]$envergadura)
mean(papagaios[papagaios$especie == "arctica",]$envergadura)

#Em média a envegadura se organiza em cirrhata > corniculata > arctica

mean(papagaios[papagaios$especie == "corniculata",]$peso)
mean(papagaios[papagaios$especie == "cirrhata",]$peso)
mean(papagaios[papagaios$especie == "arctica",]$peso)

#Em média o peso se organiza em cirrhata > corniculata > arctica

mean(papagaios[papagaios$especie == "corniculata",]$tamanho)
mean(papagaios[papagaios$especie == "cirrhata",]$tamanho)
mean(papagaios[papagaios$especie == "arctica",]$tamanho)

#Em média o tamanho se organiza em corniculata > cirrhata > arctica

sd(papagaios[papagaios$especie == "corniculata",]$envergadura)
sd(papagaios[papagaios$especie == "cirrhata",]$envergadura)
sd(papagaios[papagaios$especie == "arctica",]$envergadura)

#As árticas são menos diversas com relação à envergadura, seguida pelas corniculatas e as mais diversas com relação à envegadura são as cirrhatas

sd(papagaios[papagaios$especie == "corniculata",]$peso)
sd(papagaios[papagaios$especie == "cirrhata",]$peso)
sd(papagaios[papagaios$especie == "arctica",]$peso)

#As articas são menos diversas com relação ao peso, seguida pelas corniculatas e as mais diversas com relação ao peso são as cirrhatas

sd(papagaios[papagaios$especie == "corniculata",]$tamanho)
sd(papagaios[papagaios$especie == "cirrhata",]$tamanho)
sd(papagaios[papagaios$especie == "arctica",]$tamanho)

#As articas são menos diversas com relação ao tamanho, seguida pelas cirrhata e as mais diversas com relação ao peso são corniculata

par(mfrow = c(1, 3))
boxplot(papagaios[papagaios$especie == "corniculata",]$peso, main = "Corniculta", ylim = c(min(papagaios$peso),max(papagaios$peso)))
boxplot(papagaios[papagaios$especie == "cirrhata",]$peso, main = "Cirrhata", ylim = c(min(papagaios$peso),max(papagaios$peso)))
boxplot(papagaios[papagaios$especie == "arctica",]$peso, main = "Arctica", ylim = c(min(papagaios$peso),max(papagaios$peso)))

#As articas se testacam em peso, a mediana de seus pesos está próximo aos valores minimos das outras duas espècies, o mesmo vale para o valor max das articas, que está abaixo do primeiro quartil de cirrhata e próximo à mediana das cornicultas

##Letra C
papagaios$especie = as.factor(papagaios$especie)

##Letra D
treino = papagaios[1:floor(nrow(papagaios)*0.8),]
teste = papagaios[ceiling(nrow(papagaios)*0.8):nrow(papagaios),]

##Letra E

library(rpart)
library(rpart.plot)
sort(papagaios$peso)
papagaios <- papagaios[nrow(papagaios),]
n <- round(nrow(papagaios)*0.8)
n
treino <- papagaios[1:n,]
teste <- papagaios[(n+1):nrow(papagaios),]
treino

arvore.papagaios <- rpart(formula = Peso ~., data = treino)
rpart.plot(arvore.papagaios, exta = 101)

##Letra F

library(tree)
library(rpart)
library(rpart.plot)
modelo_papagaios = rpart(especie~., data = treino)
rpart.plot(modelo_papagaios, extra = 101)
previsao = predict(modelo_papagaios, newdata = teste, type = "class")

##Letra G

mean(previsao == teste$especie)
table(teste$especie, previsao)

#Questão 02

##Letra A

papagaios = read.csv("papagaio.txt", header = TRUE, sep = ",")
corniculata = papagaios[papagaios$especie == "corniculata",]
cirrhata = papagaios[papagaios$especie == "cirrhata",]
arctica = papagaios[papagaios$especie == "arctica",]

if(F){
  sum_prod_array = function(x,y){
    if(length(x)==0 || length(y == 0 )) return( 1);
    return (x[1,]*y[1,])+sum_prod_array(x[2:length(x)],y[2:length(y)])
  }
}

##Letra B

rFunction = function(x,y){
  n = length(x)
  somatorio1 = sum(x*y)
  somatoriox2 = sum(x*x)
  somatorioy2 = sum(y*y)
  numer = somatorio1 - n*mean(x)*mean(y)
  denom = sqrt(somatoriox2-n*mean(x)*mean(x)) * sqrt(somatorioy2-n*mean(y)*mean(y))
  return (numer/denom)
}

rFunction(corniculata$tamanho,corniculata$peso) #0.9025978
rFunction(cirrhata$tamanho,cirrhata$peso) #0.7143406
rFunction(arctica$tamanho,arctica$peso) #0.6837219

#Mais correlacionado = corniculata

##Letra C

rFunction(corniculata$tamanho,corniculata$peso)
rFunction(cirrhata$tamanho,cirrhata$peso)
rFunction(arctica$tamanho,arctica$peso)

lm(peso~tamanho, corniculata)

##Letra D

peso = function(tamanho){
  return (-300.59+tamanho*24.25)
}
peso(10) - peso(10.5) # diff = -12.125

##Letra E

peso = function(tamanho){
  if(tamanho<min(corniculata$tamanho) || tamanho>max(corniculata$tamanho))
    return ("Tamanho inválido")
  return (tamanho*24.25-300.59)
}
peso(18) #Tamanho inválido
peso(41.01) #693.9025

#Questão 03

##Letra A

azeite = read.table("olive.txt", header = TRUE, sep = ",")
azeite
summary(azeite)
str(azeite)

azeite_normalizado <- scale(azeite[,2:9])
azeite_normalizado
matriz_distancia <- dist(azeite_normalizado)
matriz_distancia

modelo <- hclust(d = matriz_distancia, method = "ward.D2")
plot(modelo, labels = azeite$region)

##Letra B

abline(h = 23, col= "red")
rect.hclust(modelo, k=5)

aglomerados <- cutree(modelo, k=5)
aglomerados

aglomerado1 <- azeite[aglomerados == 1,]$region
aglomerado1

mean(aglomerado1 == "Southern Italy")
mean(aglomerado1 == "Northern Italy")
mean(aglomerado1 == "Sardinia")

aglomerado2 <- azeite[aglomerados == 2,]$region
aglomerado2

mean(aglomerado2 == "Southern Italy")
mean(aglomerado2 == "Northern Italy")
mean(aglomerado2 == "Sardinia")

aglomerado3 <- azeite[aglomerados == 3,]$region
aglomerado3

mean(aglomerado3 == "Southern Italy")
mean(aglomerado3 == "Northern Italy")
mean(aglomerado3 == "Sardinia")

aglomerado4 <- azeite[aglomerados == 4,]$region
aglomerado4

mean(aglomerado4 == "Southern Italy")
mean(aglomerado4 == "Northern Italy")
mean(aglomerado4 == "Sardinia")

aglomerado5 <- azeite[aglomerados == 5,]$region
aglomerado5

mean(aglomerado5 == "Southern Italy")
mean(aglomerado5 == "Northern Italy")
mean(aglomerado5 == "Sardinia")

##Letra C

azeite = read.table("olive.txt", header = TRUE, sep = ",")
azeite
summary(azeite)
str(azeite)

azeite_normalizado <- scale(azeite[,2:9])

kmeans <- kmeans(x = azeite_normalizado, centers = 5, nstart = 100)
kmeans

azeite_normalizado[kmeans$cluster == 1]
plot(azeite_normalizado[,5], azeite_normalizado[,6], type = "n")

points(azeite_normalizado[kmeans$cluster == 1,5], azeite_normalizado[kmeans$cluster == 1,6], pch = 16, col = "red")

points(azeite_normalizado[kmeans$cluster == 2,5], azeite_normalizado[kmeans$cluster == 2,6], pch = 16, col = "blue")

points(azeite_normalizado[kmeans$cluster == 3,5], azeite_normalizado[kmeans$cluster == 3,6], pch = 16, col = "yellow")

points(azeite_normalizado[kmeans$cluster == 4,5], azeite_normalizado[kmeans$cluster == 4,6], pch = 16, col = "orange")

points(azeite_normalizado[kmeans$cluster == 5,5], azeite_normalizado[kmeans$cluster == 5,6], pch = 16, col = "black")

centroides <- kmeans$centers
points(x = centroides[1,5], y = centroides[1,6], col = "red", pch = 16, cex = 2)
points(x = centroides[2,5], y = centroides[2,6], col = "blue", pch = 16, cex = 2)
points(x = centroides[3,5], y = centroides[3,6], col = "yellow", pch = 16, cex = 2)
points(x = centroides[4,5], y = centroides[4,6], col = "orange", pch = 16, cex = 2)
points(x = centroides[5,5], y = centroides[5,6], col = "black", pch = 16, cex = 2)
