#lendo o conjunto de dados
protein <- read.table(file = "protein.txt", sep = "\t", header = TRUE)
head(protein)
summary(protein)

#normalizando o conjunto de dados
normalizado <- scale(protein[,2:10])

#agrupamento  hierárquico
matriz_dist  <- dist(normalizado, method = "euclidean")
fit1  <- hclust(matriz_dist, method = "ward.D2")
plot(fit1 , labels = protein$Country, hang = -1) #dendograma resultante do agrupamento hierárquico
rect.hclust(fit1 , k=5) #representação de 5 aglomerados

#extraindo  os  aglomerados
aglomerados  <- cutree(fit1 , k = 5)
aglomerado1 <- protein[aglomerados  == 1,]
aglomerado2 <- protein[aglomerados  == 2,]
aglomerado3 <- protein[aglomerados  == 3, c(1,2,6,10)]
aglomerado4 <- protein[aglomerados  == 4, c(1,2,6,10)]
aglomerado5 <- protein[aglomerados  == 5,]
aglomerado5
mean(aglomerado5$Fish)
