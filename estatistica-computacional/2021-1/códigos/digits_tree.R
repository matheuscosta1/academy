library(rpart)
library(rpart.plot)

#lendo os dados
#esse conjunto já está separado em treino (treino.csv) e teste (teste.csv)
treino <- read.csv(file = "train_digits.csv", header = TRUE, sep = ",") 
str(treino)
treino$label <- as.factor(treino$label)
nrow(treino)


tabela <- table(treino$label)
barplot(tabela) #analisando a quantidade de cada dígito no conjunto

#transformando os pixels (28x28) em uma imagem
#vamos imprimir a observação 8 do conjunto de treino
pixels <- as.numeric(treino[8,-1])
M <- matrix(pixels, ncol = 28, byrow = T)
image(M, col = gray.colors(255))

novo_pixels <- c()
for (j in unique(resto)) {
  novo_pixels <- c(novo_pixels, pixels[sort(vetor[resto == j], decreasing = T)])
}
sort(vetor[resto == j], decreasing = T)
MN <- matrix(novo_pixels, ncol = 28, byrow = T)
image(MN, col = gray.colors(255))


#a seguir, outra forma de imprimir os dígitos
B <- matrix(data = NA, ncol = 28, nrow = 28)
for (k in 1:28) {
  B[k,] <- rev(M[,k])
}
imagem <- image(B, col = grey.colors(255))

#criando o modelo de classificação a partir de uma árvore de decisão
arvore.digits <- rpart(label~., data = treino,  parms = list(split = 'gini'))
arvore <- rpart.plot(arvore.digits, extra = 101)



#classificando os dígitos do teste a partir da árvore de decisão criada acima
teste <- read.csv(file = "test_digits.csv", header = TRUE, sep = ",") #lendo o conjunto de teste
#vamos prever os 12 primeiros elementos do conjunto de teste
previsao.digits <- predict(arvore.digits, newdata = teste[1:12,], type = "class")
previsao.digits


#imprimindo os 12 primeiros elementos do conjunto de teste
par(mfrow = c(3,4))
for (i in 1:12) {
  pixels <- as.numeric(teste[i,])
  novo_pixels <- c()
  for (j in unique(resto)) {
    novo_pixels <- c(novo_pixels, pixels[sort(vetor[resto == j], decreasing = T)])
  }
  sort(vetor[resto == j], decreasing = T)
  M <- matrix(novo_pixels, ncol = 28, byrow = T)
  image(M, col = gray.colors(255))
  }

