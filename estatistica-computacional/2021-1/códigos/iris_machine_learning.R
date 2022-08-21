library(tree)
library(rpart)
library(rpart.plot)
library(randomForest)
set.seed(9)
#lendo o conjunto de dados iris
#separando o conjunto em dois conjuntos: uma para treino e outro para teste
#80% dos dados irão para treino e 20% para teste
set.seed(2908)
data(iris)
n <- round(nrow(iris)*0.8) #80% dos dados irão para treino
indices <- sample(nrow(iris)) #embaralhando os índices do conjunto original
iris <- iris[indices,]
treino <- iris[1:n,]
teste <- iris[(n + 1):nrow(iris), ]

#analisando as observações do treino e do teste por categoria
table(treino$Species)
table(teste$Species)

#separando o conjunto de treino por espécie
#faremos isso para estudar cada espécie separadamente
setosa <- treino[treino$Species == "setosa", ]
versicolor <- treino[treino$Species == "versicolor",]
virginica <- treino[treino$Species == "virginica", ]
summary(setosa)
summary(versicolor)
summary(virginica)

#criando um modelo de classificação da espécie da flor a partir do modelo KNN com 1 vizinho
#KNN = k nearest neighbor; aqui k= 1, o número de vizinhos considerados
classificacao <- c()
for(i in 1:nrow(teste)){
  if(teste$Petal.Width[i] <= 0.8){
    classificacao[i] <- "setosa"
  }else{
    if(teste$Petal.Length[i] <= 4.850){
      classificacao[i] <- "versicolor"
    }else{
      classificacao[i] <- "virginica"
    }
  }
}
mean(teste$Species == classificacao)#taxa de acerto

#criando um modelo de classificação da espécie da flor a partir de uma árvore de decisão com o pacote tree
tree.iris <- tree(Species~., data = treino, split = "gini")
plot(tree.iris)
text(tree.iris, cex = 0.75, col = "red")
predicao.iris <- predict(tree.iris, newdata = teste[,-5], type = "class")
table(predicao.iris, teste[,5])

##criando um modelo de classificação da espécie da flor a partir de uma árvore de decisão com o pacote rpart
arvore.iris <- rpart(Species~., data = treino,  parms = list(split = 'gini'))
fit2 <- rpart(Species ~ Petal.Length + Petal.Width, data = treino, parms = list(split = "gini"))
rpart.plot(arvore.iris, extra = 101)
previsao.iris <- predict(arvore.iris, newdata = teste[,-5], type = "class")
table(previsao.iris, teste$Species)
rpart.plot(fit2, extra = 101)
##criando um modelo de classificação da espécie da flor a partir do random forest
rf.iris <- randomForest(Species ~ ., data=treino, ntree = 500)
rf.iris

previsao.iris <- predict(rf.iris, newdata=teste)
cm = table(teste$Species, previsao.iris)
cm
cm2 = table(previsao.iris, teste$Species)
cm2


