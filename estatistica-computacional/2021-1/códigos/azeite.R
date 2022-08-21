azeite <- read.table("olive.txt", header = TRUE, sep = ",")#lendo o conjunto de dados
str(azeite)#estrutura do conjunto de dados
azeite <- azeite[sample(nrow(olive)),]#embaralhando o conjunto

n <- round(nrow(azeite)*0.8)

treino <- olive[1:n,] #separando 80% dos dados para treino do modelo
teste <- olive[-(1:n),] #20% restante para teste

#classficacao com knn
classificacao <- c()
for (i in 1:nrow(teste)) {
  distancias <- c()
  for (j in 1:nrow(treino)) {
    distancias[j] <- sqrt(sum((treino[j,-1]  - teste[i, -1])^2))
  }
  classificacao[i] <- order(distancias)[1]
}
classificacao
nomes <- treino$region[classificacao]
nomes
mean(nomes == teste$region)

#classificacao pelo método da árvore de decisao

#dividindo o conjunto treino pelas regiões
#essa divisão nos permitirá conhecer as características de cada região
treino_sardinia <- treino[treino$region == "Sardinia",]
treino_southern <- treino[treino$region == "Southern Italy",]
treino_northern <- treino[treino$region == "Northern Italy",]
summary(treino_sardinia)
summary(treino_northern)
summary(treino_southern)

#a partir fo estudo de cada região, encontramos a seguinte regra de classificação
classificacao <- c()
for (i in 1:nrow(teste)) {
  if(teste$eicosenoic[i] > 0.065){
    classificacao[i] <- "Southern Italy"
  }else{
    if(teste$linoleic[i] > 10.535 ){
      classificacao[i] <- "Sardinia"
    }else{
      classificacao[i] <- "Northern Italy"
    }
  }
}

#a taxa de acerto é:
mean(teste$region == classificacao)


#vamos usar agora alguns pacotes do R que constroem árvores de decisão.
#inicialmente, vamos usar o pacote tree.
install.packages("tree")
library(tree)
tree.olive <- tree(region ~., data=treino, split = "gini")
plot(tree.olive)
text(tree.olive)
summary(tree.olive)
predicao.olive <- predict(tree.olive, newdata = teste[,-1], type = "class")
table(teste$region, predicao.olive)
mean(predicao.olive == teste$region)
#vamos usar agora o pacote rpart
install.packages("rpart")
library(rpart)
arvore.olive <- rpart(region~., data = treino)
rpart.plot(arvore.olive)
previsao <- predict(arvore.olive, newdata = teste[,-1], type = "class")
previsao
table(previsao, teste$region)
