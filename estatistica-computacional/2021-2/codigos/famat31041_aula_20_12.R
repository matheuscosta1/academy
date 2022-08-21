data(iris)
set.seed(2012)#colocando uma semente para sempre obter a mesma amostra na linha 3
iris <- iris[sample(nrow(iris)),] #embaralhando o conjunto de dados
iris

z <- round(0.8*nrow(iris)) #separando 80% para treino e deixando os 20% restantes para teste
treino <- iris[1:z,]
teste <- iris[(z+1):nrow(iris),]

#a seguir, criaremos um data frame para cada espécie
setosa <- treino[treino$Species == "setosa",]
versicolor <- treino[treino$Species == "versicolor",]
virginica <- treino[treino$Species == "virginica", ]

#construindo um gráfico de tamanho versus largura da pétala e identificando cada espécie por uma cor diferente
plot(treino$Petal.Length, treino$Petal.Width, type = "n", xlab = "Tamanho da pétala", ylab = "Largura da pétala")
points(setosa$Petal.Length, setosa$Petal.Width, pch = 16, col = "red")
points(versicolor$Petal.Length, versicolor$Petal.Width, pch = 16, col = "blue")
points(virginica$Petal.Length, virginica$Petal.Width, pch = 16, col = "green")

#ordenando os valores da largura da versicolor para escolher a região de classificação dessa espécie.
sort(versicolor$Petal.Width)

#conforme a inspeção gráfica, as regiões de classficação podem ser delimitadas assim:
abline(v = 2.5)
segments(x0 = 2.5, y0 = 1.65, x1 = 8, y1 = 1.65)


#criando uma árvore de decisão
classificacao <- c()
for (j in 1:nrow(teste)) {
  if(teste$Petal.Length[j] < 2.5){
    classificacao[j] <- "setosa"
  }else{
    if(teste$Petal.Width[j] < 1.65){
      classificacao[j] <- "versicolor"
    }else{
      classificacao[j] <- "virginica"
    }
  }
}

classificacao == teste$Species
mean(classificacao == teste$Species)#proporção de acertos

table(classificacao, teste$Species)#matriz de confusão; esta matriz nos possibilita comparar as taxas de acertos dentro de cada espécie.
