data(iris)
dados <- iris[,1:4]
dados
str(dados)
dados <- scale(dados) #normalizando os dados
kmeans.iris <- kmeans(x = dados, centers = 3, nstart = 20) #modelo k-means com 3 aglomerados
kmeans.iris #observe que ao imprimir o modelo, o R retorna os componentes disponíveis, como cluster and centers (os centroides)
kmeans.iris$cluster == 1 # quem está no aglomerado 1?

dados[kmeans.iris$cluster == 1,] #extraindo as observações que estão no aglomerado 1
plot(dados[,3], dados[,4], type = "n")
points(dados[kmeans.iris$cluster == 1,3], dados[kmeans.iris$cluster == 1,4], pch =16, col = "red")

points(dados[kmeans.iris$cluster == 2,3], dados[kmeans.iris$cluster == 2,4], pch =16, col = "orange")

points(dados[kmeans.iris$cluster == 3,3], dados[kmeans.iris$cluster == 3,4], pch =16, col = "blue")

centroides <- kmeans.iris$centers
points(x = centroides[1, 3], y = centroides[1, 4], col="red", pch = 10, cex = 2) #plotando o centróide do aglomerado vermelho.
