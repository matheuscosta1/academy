library(tree)
library(rpart)
library(rpart.plot)
data(iris)
iris <- iris[sample(150),]
n <- round(length(iris$Species)*0.8)
treino <- iris[1:n,]  
teste <- iris[(n+1):150,]

setosa <- treino[treino$Species == "setosa", ]
virginica <- treino[treino$Species == "virginica", ]
versicolor <- treino[treino$Species == "versicolor", ]
plot(treino$Petal.Length, treino$Petal.Width, type = "n", xlab = "Tamanho da pétala", ylab = "Largura da pétala", main = "Petála da iris")
points(setosa$Petal.Length, setosa$Petal.Width, pch = 16, col = "orange", cex = 0.5)
points(virginica$Petal.Length, virginica$Petal.Width, pch = 16, col = "red", cex = 0.5)
points(versicolor$Petal.Length, versicolor$Petal.Width, pch = 16, col = "blue", cex = 0.5)

boxplot(versicolor$Petal.Width, virginica$Petal.Width, names = c("versicolor", "virginica"))

summary(versicolor)
summary(virginica)
mean(versicolor$Petal.Width < 1.6)

classificacao <- c()
for(j in 1:length(teste$Species)){
  if(teste$Petal.Length[j] < 2.5){
    classificacao <- c(classificacao, "setosa")
  }else{
    if(teste$Petal.Width[j] < 1.6){
      classificacao <- c(classificacao, "versicolor")
    }else{
      classificacao <- c(classificacao, "virginica")
    }
  }
}
classificacao
teste$Species
mean(classificacao == teste$Species)

modelo1 <- tree(formula = Species ~., data = treino, split = "gini")
plot(modelo1)
text(modelo1)
previsao <- predict(modelo1, newdata= teste[,1:4], type = "class")
previsao
mean(previsao == teste$Species)
table(previsao, teste$Species)
25/30
modelo1
iris
sort(iris$Sepal.Length)

###############
#azeite
###############
azeite <- read.table("olive.txt", header = TRUE, sep = ",")
str(azeite)
azeite$region <- as.factor(azeite$region)
str(azeite)
azeite$region

572*0.8
n <- 457
indices <- sample(572)
azeite <- azeite[indices, ]
treino <- azeite[1:n, ]
teste <- azeite[(n+1):572, ]

sul <- treino[treino$region == "Southern Italy", ]
norte <- treino[treino$region == "Northern Italy", ]
sardinia <- treino[treino$region == "Sardinia", ]

summary(sul)
summary(norte)
summary(sardinia)

classificacao <- c()
length(teste$region)

for (j in 1:115) {
  if(teste$eicosenoic[j] >= 0.065 ){
    classificacao[j] <- "sul"
  }else{
    if(teste$linoleic[j] < 10.535){
      classificacao[j] <- "norte"
    }else{
      classificacao[j] <- "sardinia"
    }
  }
}
classificacao
table(classificacao, teste$region)


#iris
modelo.iris <- tree(Species ~., data = treino, split = "gini")
plot(modelo.iris)
text(modelo.iris)

modelo2.iris <- rpart(Species ~., data = treino, parms = list(split = "gini"))
rpart.plot(modelo2.iris, extra = 101)

cancer <- read.table("cancer.txt", header = TRUE, sep = ",")
str(cancer)

n <- round(length(cancer$Class)*0.8)
indices <- sample(699)
cancer <- cancer[indices,] 
cancer

treino <- cancer[1:n, ]
teste <- cancer[(n+1):699, ]
modelo.cancer <- rpart(formula  = Class ~ ., data = treino, parms = list(split = "gini"))
rpart.plot(modelo.cancer, extra = 101)
previsao.cancer <- predict(modelo.cancer, newdata = teste[,1:9], type = "class")
previsao.cancer
mean(previsao.cancer == teste$Class)
table(previsao.cancer, teste$Class)

titanic
str(titanic)
titanic <- titanic[, -1]
str(titanic)

summary(titanic)

modelo.azeite <- rpart(region ~., data = treino, parms = list(split = "gini"), method = "class")
rpart.plot(modelo.azeite, extra = 101)

