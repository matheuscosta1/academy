library(rpart)
library(rpart.plot)

#lendo os dados
#esse conjunto j? est? separado em treino (treino.csv) e teste (teste.csv)
treino <- read.csv(file = "train_digits.csv", header = TRUE, sep = ",") 
str(treino)
treino$label <- as.factor(treino$label)
nrow(treino)
treino$label <- as.factor(treino$label)

tabela <- table(treino$label)
barplot(tabela) #analisando a quantidade de cada d?gito no conjunto

#transformando os pixels (28x28) em uma imagem
#vamos imprimir a observa??o 8 do conjunto de treino
pixels <- as.numeric(treino[100,-1])
M <- matrix(pixels, ncol = 28, byrow = T)
image(M, col = gray.colors(255))

vetor <- 1:784
resto <- vetor %% 28
novo_pixels <- c()
for (j in unique(resto)) {
  novo_pixels <- c(novo_pixels, pixels[sort(vetor[resto == j], decreasing = T)])
}
MN <- matrix(novo_pixels, ncol = 28, byrow = T)
image(MN, col = gray.colors(255))


#a seguir, outra forma de imprimir os d?gitos
B <- matrix(data = NA, ncol = 28, nrow = 28)
for (k in 1:28) {
  B[k,] <- rev(M[,k])
}

image(B, col = grey.colors(255))

#criando o modelo de classifica??o a partir de uma ?rvore de decis?o
arvore.digits <- rpart(label~., data = treino,  parms = list(split = 'gini'))
arvore <- rpart.plot(arvore.digits, extra = 101)



#classificando os d?gitos do teste a partir da ?rvore de decis?o criada acima
teste <- read.csv(file = "test_digits.csv", header = TRUE, sep = ",") #lendo o conjunto de teste

#vamos prever os 9 primeiros elementos do conjunto de teste
previsao.digits <- predict(arvore.digits, newdata = teste[1:9,], type = "class")
previsao.digits


#imprimindo os 9 primeiros elementos do conjunto de teste
par(mfrow = c(3,3))
for (i in 1:9) {
  pixels <- as.numeric(teste[i,])
  novo_pixels <- c()
  for (j in unique(resto)) {
    novo_pixels <- c(novo_pixels, pixels[sort(vetor[resto == j], decreasing = T)])
  }
  M <- matrix(novo_pixels, ncol = 28, byrow = T)
  image(M, col = gray.colors(255))
  }

treino[6,]

heart
str(heart)
