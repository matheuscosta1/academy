library(datasets) #lendo o pacote datasets; este pacote contém vários conjunto de dados; utilizaremos, particularmente, o conjunto de dados chamado iris.
iris #imprimindo o conjunto iris
str(iris) #a função str informa a estrutura do conjunto, por exemplo: números de observações, número de variáveis e nome das variáveis.

tamanho.petala <- iris$Petal.Length #acessando uma coluna do conjunto e salvando-a no objeto tamanho.petala
head(iris, n = 10) #a função head imprime as primeiras linhas de um conjunto de dados; por padrão, n = 6, em que n é o número de linhas impressas.
tail(iris) # a função tail imprime as últimas linhas de um conjunto de dados; assim como head, o padrão é n = 6.
summary(iris) #a função summary retorna um resumo de algumas medidas estatísticas para cada variável do conjunto; útil para variáveis numéricas e categóricas, por exemplo.
levels(iris$Species) # a função levels retorna o nome das categorias de uma variável do tipo factor.

#a seguir, vamos criar, a partir de iris, três novos data frame, um para cada espécie: setosa, versicolor, virginica.

setosa <- iris[iris$Species == "setosa",]
setosa

versicolor <- iris[iris$Species == "versicolor",]
versicolor

virginica <- iris[iris$Species == "virginica",]
virginica

class(setosa) #observe que setosa, assim como iris, é um data frame
summary(setosa)
summary(iris)


a <- summary(setosa$Sepal.Length) #guardando o resumo estatístico de uma variável no objeto a
a <- round(a, digits = 2) #arredondando números com duas casas decimais

#a seguir, vamos plotar alguns boxplots para conhecermos cada uma das espécies

boxplot(setosa$Sepal.Length, versicolor$Sepal.Length, virginica$Sepal.Length, names = c("setosa", "versicolor", "virginica"), main = "Tamanho da sépala")

boxplot(setosa$Sepal.Width, versicolor$Sepal.Width, virginica$Sepal.Width, names = c("setosa", "versicolor", "virginica"), main = "Largura da sépala")

boxplot(setosa$Petal.Length, versicolor$Petal.Length, virginica$Petal.Length, names = c("setosa", "versicolor", "virginica"), main = "Tamanho da pétala")

boxplot(setosa$Petal.Width, versicolor$Petal.Width, virginica$Petal.Width, names = c("setosa", "versicolor", "virginica"), main = "Largura da pétala")

# a seguir, vamos plotar um gráfico de Tamanho da pétala versus Largura da pétala; no gráfico final cada espécie será registrada por uma cor diferente.

plot(x = iris$Petal.Length, y = iris$Petal.Width, xlab =  "Tamanho da pétala", ylab = "Largura da Pétala", main = "Tamanho versus Largura", pch = 16, type = "n")

points(setosa$Petal.Length, setosa$Petal.Width, pch = 16, col = "blue")

points(versicolor$Petal.Length, versicolor$Petal.Width, pch = 16, col = "red")

points(virginica$Petal.Length, virginica$Petal.Width, pch = 16, col = "green")

iris <- iris[sample(nrow(iris)),] #embaralhando as observações de iris
iris #observe como as observações foram embaralhadas; antes o conjunto estava organizado por espécie, agora não mais.

total_treino <- floor(0.8*nrow(iris)) #separando 80% dos dados para treinamento; usamos a função floor para garatirmos que o npumero total_treino fosse inteiro; pesquise ?floor no console para ver como esta função funcione; tente entender a diferença dela para a função ceiling; poderia-se utilizar também a função round.
treino <- iris[1:total_treino, ] #selecionando 80% das observações e salvando-as em treino.
teste <- iris[(total_treino + 1): nrow(iris),] #as observações que não foram para treino, foram alocadas em teste; 
teste
str(teste)
str(treino)

#nas próximas quatro linhas, fizemos um passo a passo para calcular a distancia da observação 1 de teste para a observação 1 de treino levando em consideração apenas as variáveis Petal Lenght e Petal Width (colunas 3 e 4).
teste[1,c(3,4)] - treino[1,c(3,4)]
(teste[1,c(3,4)] - treino[1,c(3,4)])^2
sum((teste[1,c(3,4)] - treino[1,c(3,4)])^2)
sqrt(sum((teste[1,c(3,4)] - treino[1,c(3,4)])^2)) #aqui a distância

#a seguir, um exemplo de laço no R
vetor <- c(3,5,10)
soma <- 0
for(j in 1:10){
  print(j)
}

#vamos calcular a distancia da observação 1 do teste para cada observação do treino; cada uma das distâncias será guardada no vetor distancias; assim, por exemplo, a posição 9 de distancias representa a distância da observação 1 de teste para a observação 9 do treino; repare também, no laço, que a posição 1 de teste está fixa (teste[1,c(3,4)]) enquanto as observações de treino estão variando por j; por fim, lembre-se que estamos levando em consideração apenas as colunas 3 e 4.
distancias <- c()
for(j in 1:nrow(treino)){
  distancias[j] <- sqrt(sum((teste[1,c(3,4)] - treino[j,c(3,4)])^2))
}
distancias
order(distancias)[1] #identificando a observação de treino que está mais próxima da observação 1 de teste
treino[order(distancias)[1],5] #a classificação da observação 1 de teste será dada pela classificação da observação encontrada na linha anterior.

#agora, vamos encontrar para cada observação K de teste, a observação de treino que está mais próxima desse observação K e extrair a classificação dela para a observação K. 
classificacao <- c()
for (k in 1:nrow(teste)) {
distancias <- c()
for(j in 1:nrow(treino)){
    distancias[j] <- sqrt(sum((teste[k,c(3,4)] - treino[j,c(3,4)])^2))
}
classificacao[k] <- as.character(treino[order(distancias)[1],5])
}
classificacao == teste$Species
mean(classificacao == teste$Species) #taxa de acerto



