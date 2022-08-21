#matrizes
A <- matrix(data = c(7,10,12,22,22,40), ncol = 3, byrow = TRUE) #criando uma matriz, o argumento ncol é para o número de colunas e byrow se os dados devem ou não ser preenchidos pelas linhas

A[2,2] #acessando o elemento da segunda linha e da segunda coluna
A[1,] #acessando a primeira linha
A[,3] #acessando a terceira coluna
B <- A[, c(1,3)]# atribuindo as colunas 1 e 3 de A à variável B
B 
colnames(A) <- c("A", "B", "C") #alterando os nomes das colunas
A[,"B"]
A
rownames(A) <- c("Q", "W") #alterando os nomes das linhas
A["Q", "B"]
A[1,3] <- 13
g <- A[,3][c(2,1)]
g[2]

A[-1,] #matriz resultante da exclusão da primeira linda de A
A #a matriz A permanece inalterada
cbind(A, c(34,78), c(54, 43)) #acrescentando colunas à matriz A.
B <- rbind(A, c(1,2,56)) #com a função "rbind" acrescentamos uma linha à matriz A e essa nova matriz foi atribuída à variável B.
B

#data frames
install.packages(dslabs) #instalando o pacote "dslabs"
library(dslabs) #lendo o pacote "dslabs"
data(murders) #lendo o conjunto de dados "murders" do pacote "dslabs"
dados <- murders #é possível salvar o conjunto murders dentro de uma variável; analagomente, poderia se salvar apenas um subconjunto de murders numa variável, como a seguir:
dados <- murders[, c(1,3)]


murders #imprimindo o conjunto murders
head(murders) #lendo apenas as seis primeiras entradas de murders
tail(murders) #lendo as seis últimas entradas de murders
str(murders) #estrutura do conjunto de dados; quantas observações, quantas variáveis, etc.
murders[,1] #primeira coluna de murders
murders[5,] #quinta linha de murders
summary(murders) #resumo estatístico do conjunto de dados

#outra forma de acessar uma coluna é utilizando $; assim se quer acessar a coluna "state" ou "region" deve-se proceder assim, respectivamente: murders$state ou murders$region
estados <- murders$state 
estados

murders$total #acessando apenas a coluna "total"; essa coluna apresenta o número de mortes por armas de fogo em cada estado
sum(murders$total) #total de mortes por arma de fogo em 2010 nos EUA.
order(murders$total)


rate <- 100000*murders$total/murders$population #criando um vetor chamado rate que conterá a taxa de mortes por armas de fogo em relação a 100 mil habitantes
rate
indices <- order(rate)
indices

murders[indices[length(indices)],]$state #qual o estado mais violento?

murders[indices[1], 1] #qual o estado menos violento?
murders[indices, 1] #ordenação dos estados do menos violento para o mais violento.

murders <- cbind(murders, rate) #acrescentando a coluna rate ao conjunto de dados
murders
str(murders) #observe que agora temos uma nova variável
murders$rate <- rate #outra forma de acrescentar uma nova coluna a um conjunto de dados existente
head(murders)
murders[,c(1,3,6)] #colunas 1, 2 e 6 de murders


murders$rate >= 1.2526 & murders$rate <= 3.3861 #quais são as observações de murders que possuem taxa maior do que 1.2526 e menor do que 3.3861? 
murders[rate >= 1.2526 & rate <= 3.3861,]$state #imprimindo os nomes dos estados da pergunta anterior

plot(x = murders$population, y = murders$rate)
max(rate)
murders$rate == max(rate)
murders[murders$rate == max(rate),]
mean(murders$rate)
mean(murders$population)
boxplot(murders$rate)
hist(murders$rate)
summary(murders$rate)
levels(murders$region)

#criando um conjunto de dados que conterá apenas estados da região nordeste
murders$region == "Northeast"
nordeste <- murders[murders$region == "Northeast", ]
nordeste <- nordeste[,-3]
nordeste

#criando um conjunto de dados que conterá apenas estados da região sul
sul <- murders[murders$region == "South", ]
sul <- sul[,-3]
sul

#criando um conjunto de dados que conterá apenas estados da região centro-norte
centro_norte <- murders[murders$region == "North Central", ]
centro_norte[,-3]

#criando um conjunto de dados que conterá apenas estados da região oeste.
oeste <- murders[murders$region == "West", ]
oeste

boxplot(leste$rate, main = "leste")
boxplot(nordeste$rate, main = "nordeste")
hist(nordeste$rate)
hist(leste$rate)


par(mfrow = c(1,2)) #criando uma janela em plots que exibirá dois gráficos de uma vez em uma linha e duas colunas.
boxplot(centro_norte$rate, main = "centro norte", ylim = c(min(rate), max(rate)))
boxplot(sul$rate, main = "sul", ylim = c(min(rate), max(rate)))
text(y = boxplot.stats(sul$rate)$stats, labels = boxplot.stats(sul$rate)$stats, x = 1.36)

#plotando um gráfico de população versus taxa de morte e diferenciando os estados por região

par(mfrow = c(1,1)) #exibir apenas um único gráfico
plot(x = murders$population, murders$rate, pch = 16, cex = 1, type = "n")
points(sul$population, sul$rate, pch = 16, col = "red")
points(centro_norte$population, centro_norte$rate, pch = 16, col = "green")
points(oeste$population, oeste$rate, pch = 16, col = "blue")

