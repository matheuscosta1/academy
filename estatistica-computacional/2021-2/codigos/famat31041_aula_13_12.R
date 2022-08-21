install.packages(dslabs) #instalando o pacote dslbas
library(dslabs) #lendo o pacote dslabs

#vamos trabalhar com o conjunto de dados murders; você pode imprimir este conjunto digitando murders e executando a linha; você também poderia guardar o conjunto dentro de outra variável, como por exemplo, dentro de conjunto.dados:

murders
conjunto.dados <- murders
conjunto.dados

head(murders, n = 3) #imprimindo as três primeiras observações de murders
tail(murders, n = 7) #imprimindo as sete últimas observações de murders

str(murders) #imprimindo a estrutura de murders
summary(murders) #a função summary retorna um resumo de medidas estatísticas para as variáveis de um conjunto de dados

rate <- 100000*murders$total/murders$population #criando uma variável chamada rate; esta variável representa o número de mortes por arma de fogo a cada cem mil habitantes
rate        

murders <- cbind(murders, rate) #adicionando a variável rate ao conjunto murders
str(murders)
murders <- murders[,-c(2,5)] #deletando as colunas 2 e 5 de murders.

#caso você queira recuperar o conjunto original, você pode utilizar a função data
data(murders)
murders #observe que murders não tem mais, por exemplo, a variável rate

murders$rate <- rate #outra forma de adicionar uma variável a um conjunto
str(murders)
murders <- murders[,-c(2,5)]
str(murders)
order(murders$rate)[1:5] #imprimindo as posições dos 5 estados menos violentos
murders[order(murders$rate)[1:5],]$region #imprimindo a região dos estados menos violentos

order(murders$rate)[nrow(murders)] #posição do estado mais violento
murders[order(murders$rate)[nrow(murders)],] #estado mais violento

#vamos, a seguir, criar um conjunto para cada região, isto é, o conjunto se.sul conterá apenas estados da região sul, por exemplo.
se.sul <- murders$region == "South"
se.oeste <- murders$region == "West"
se.nordeste <- murders$region == "Northeast"
se.centro <- murders$region == "North Central"

sul <- murders[se.sul, -2] #deletando a coluna região, pois já sabíamos que todos os estados de se.sul pertencem à região sul
sul

nordeste <- murders[se.nordeste, -2]
nordeste

oeste <- murders[se.oeste,-2]
oeste

centro <- murders[se.centro, -2]
centro

mean(sul$rate)
mean(oeste$rate)
mean(nordeste$rate)
mean(centro$rate)

#quantos estados possuem taxa inferior a 1?
#quem são estes estados?

murders$rate < 1
sum(murders$rate < 1)
murders[murders$rate < 1,]$state

any(murders$rate < 1)
menor1 <- which(murders$rate < 1)
length(menor1)
murders$state[menor1]

#AND e OR

murders$rate < 1

murders$region == "West"

(murders$rate < 1)&(murders$region == "West")

murders$state[(murders$rate < 1)&(murders$region == "West")]

murders$rate < 1 | murders$rate > 2
murders$state[(murders$rate < 1)|(murders$rate > 2),]

table(murders$region)
barplot(table(murders$region), main = "Número de estados por região", las = 1, xlab = "Regiões", ylab = "Quantidade de estados", ylim = c(0,20))

class(table(murders$region))

hist(murders$population)
hist(murders$rate, main = "Distribuição das taxas")

par(mfrow = c(1,2))
boxplot(sul$rate, ylim = c(0, 20), main= "Sul")
boxplot(centro$rate, ylim = c(0,20), main = "Centro Norte")

boxplot(sul$rate, centro$rate, nordeste$rate, oeste$rate,names = c("sul", "centro norte", "nordeste", "oeste"))
hist(oeste$rate)
