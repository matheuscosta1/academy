#lendo o pacote datasets para acessar, em seguida, o conjunto iris
library(datasets)
data(iris)

#separando o conjunto de dados por esp?cies
virginica <- iris[iris$Species == "virginica",]
versicolor <- iris[iris$Species == "versicolor",]
setosa <- iris[iris$Species == "setosa",]

#criar boxplot para cada esp?cie
par(mfrow = c(1,3), mar = c(7, 2, 2, 1))
boxplot(virginica[,1:4], main = "virginica", ylim = c(0,8), las = 2)
boxplot(versicolor[,1:4], main = "versicolor", ylim = c(0,8), las = 2)
boxplot(setosa[,1:4], main = "setosa", ylim = c(0,8), las = 2)

#criando um gr?fico para tamanho versus largura da p?tala
par(mfrow = c(1,1))
plot(iris$Petal.Length, iris$Petal.Width, type = "n")
points(virginica$Petal.Length, virginica$Petal.Width, col = "red", pch = 19, cex = 1.5)
points(versicolor$Petal.Length, versicolor$Petal.Width, col = "blue", pch = 19, cex = 1.5)
points(setosa$Petal.Length, setosa$Petal.Width, col = "green", pch = 19, cex = 1.5)

#criando um modelo de previsao
indices <- sample(1:150, size = 150, replace = FALSE)
nova_iris <- iris[indices,]
treino <- nova_iris[1:120,]
teste <- nova_iris[121:150,]


distancia1 <- sqrt((teste[1,1] - treino[1,1])^2 + (teste[1,2] - treino[1,2])^2
                   + (teste[1,3] - treino[1,3])^2 + (teste[1,4] - treino[1,4])^2)


distancias1 <- c()
for (i in 1:120) {
  distancias1[i] <- sqrt((teste[1,1] - treino[i,1])^2 + (teste[1,2] - treino[i,2])^2
                         + (teste[1,3] - treino[i,3])^2 + (teste[1,4] - treino[i,4])^2)
}
order(distancias1)
treino[90,5]

resultado <- c()
for(j in 1:30){
  distancias <- c()
  for (i in 1:120) {
    distancias[i] <- sqrt((teste[j,1] - treino[i,1])^2 + (teste[j,2] - treino[i,2])^2
                           + (teste[j,3] - treino[i,3])^2 + (teste[j,4] - treino[i,4])^2)
  }
  resultado[j] <- order(distancias)[1]
}

classificacao <- treino[resultado, 5]
acuracia <- sum(classificacao == teste$Species)/30
acuracia

