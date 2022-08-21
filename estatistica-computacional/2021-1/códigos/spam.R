#floresta aleatória do conjunto da flor iris
data(iris)
iris <- iris[sample(150),]
treino <- iris[1:120, ]
teste <- iris[121:150, ]

par(mfrow = c(2,3))
for(j in 1:6){
  valores <- sample(1:120, size = 120, replace = TRUE)
  reamostra <- treino[valores,]
  modelo <- rpart(Species~., data = reamostra, parms = list(split = "gini"))
  rpart.plot(modelo, extra = 101)
}


fit1 <- randomForest(Species~., data = treino)
fit1

plot(fit1)
previsao <- predict(fit1, newdata = teste[,-5], type = "class")
previsao
mean(previsao == teste$Species)

#floresta aleatória para previsao de spam
spam <- read.table("spam.txt", header = F, sep = " ")
str(spam)
spam$V58 <- as.factor(spam$V58)
str(spam)
table(spam$V58)

spam <- spam[sample(nrow(spam)), ]
n <- round(0.8*nrow(spam))
treino <- spam[1:n, ]
teste <- spam[-(1:n),]

fit2 <- randomForest(V58~., data = treino)
fit2

previsao2 <- predict(fit2, newdata = teste[,-58], type = "class")
mean(previsao2 == teste$V58)
