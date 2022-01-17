library(tree)
library(rpart)
library(rpart.plot)
library(randomForest)

#importanto o conjunto "cancer.csv"
dados <- read.csv("cancer.csv", header = TRUE, sep = ",")
str(dados)
dados$diagnosis <- as.factor(dados$diagnosis) #transformando a variável diagnosis em uma
#variável do tipo categórica (factor); originalmente, ela foi interpretada como uma string
dados <- dados[,-c(1,33)] #excluindo a primeira e a última coluna de dados


#criando um conjunto para treino e um conjunto para teste
n <- round(nrow(dados)*0.8) #80% dos dados irão para treino
indices <- sample(nrow(dados)) #embaralhando os índices do conjunto original
treino <- dados[indices[1:n],] #selecionando os primeiros 80% dos índices para treino
teste <- dados[indices[(n+1):569],] #os 20% restantes irão para teste

#os dois comandos a seguir nos possibilitam ver a quantidade de observações
#em cada uma das categorias; compare esses resultados com as observações do conjunto dados
table(treino$diagnosis)
prop.table(table(treino$diagnosis))

#criando um modelo de classificação de tumores a partir do modelo de árvore de decisão
arvore.cancer <- rpart(diagnosis~., data = treino,  parms = list(split = 'gini'))
rpart.plot(arvore.cancer, extra = 101)
previsao.cancer <- predict(arvore.cancer, newdata = teste, type = "class") #fazendo previsões a partir do conjunto teste
table(teste$diagnosis, previsao.cancer ) #criando uma matriz de confusão para averiguar os acertos e erros da previsão em cada categoria

#criando um modelo de classificação de tumores a partir do modelo de floresta aleatória
rf.cancer <- randomForest(diagnosis ~ ., data=treino)
rf.cancer


previsao.cancer <- predict(rf.cancer, newdata=teste) #fazendo previsões a partir do conjunto teste
cm = table(teste[,1], previsao.cancer) #criando uma matriz de confusão para averiguar os acertos e erros da previsão em cada categoria
print(cm)
