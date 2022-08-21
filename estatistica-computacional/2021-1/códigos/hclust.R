#criando um conjunto de dados fictício e analisando os efeitos no dendograma de cada medida de distância entre grupos.

set.seed(123)
x1 <- runif(1000, -2, 2)
y1 <- runif(1000, -2, 2)
circulo_fora <- x1^2 + y1^2 <= 4 &  x1^2 + y1^2 >= 1


x2 <- runif(1000, -1, 1)
y2 <- runif(1000, -1, 1)
circulo_dentro <- x2^2 + y2^2 <= 1


plot(x1, y1, type = "n")
points(x1[circulo_fora], y1[circulo_fora], pch = 16)
points(x2[circulo_dentro], y2[circulo_dentro], pch = 16)

X <- c(x1[circulo_fora], x2[circulo_dentro])
Y <- c(y1[circulo_fora], y2[circulo_dentro])

dados <- data.frame(X,Y)
escala <- scale(dados)
matriz <- dist(escala, method = "euclidean")
modelo1 <- hclust(matriz, method = "single")


aglomerados <- cutree(modelo1, k=2)
valor1 <- aglomerados == 1
valor2 <- aglomerados == 2


plot(x1, y1, type = "n")
points(dados$X[valor1], dados$Y[valor1], pch = 16, col = "red")
points(dados$X[valor2], dados$Y[valor2], pch = 16, col = "blue")

#agora pelo método complete
modelo2 <- hclust(matriz, method = "complete")
aglomerados <- cutree (modelo2, k=2)
vvalor1 <- aglomerados == 1
vvalor2 <- aglomerados == 2


plot(x1, y1, type = "n")
points(dados$X[vvalor1], dados$Y[vvalor1], pch = 16, col = "red")
points(dados$X[vvalor2], dados$Y[vvalor2], pch = 16, col = "blue")

#########################################
#outro exemplo sobre a escolha da linkage
#########################################
#diferentes linkages
x_dentro <- runif(2000, -1.5,1.5)
y_dentro <- runif(2000, -1.5, 1.5)

circulo_interior <- (x_dentro^2 + y_dentro^2 <= (1.5)^2) & (x_dentro^2 + y_dentro^2 >= (1)^2)


x_anel <- runif(10000, -3, 3)
y_anel <- runif(10000, -3,3)
anel <- (x_anel^2 + y_anel^2 <= 9) & (x_anel^2 + y_anel^2 >= 4)

plot(c(-3,3), c(-3,3), type = "n")
points(x_dentro[circulo_interior], y_dentro[circulo_interior], pch = 16)
points(x_anel[anel], y_anel[anel], pch = 16)

dados1 <- data.frame(x = x_dentro[circulo_interior], y = y_dentro[circulo_interior], label = rep(1, times = length(x_dentro[circulo_interior])))
dados2 <- data.frame(x = x_anel[anel], y = y_anel[anel], label = rep(2, times  = length(x_anel[anel])))
dados <- rbind(dados1, dados2)
dados

#minimo
minimo <- scale(dados[,1:2])
matriz_minimo <- dist(minimo)
model_minimo <- hclust(matriz_minimo, method = "single")
plot(model_minimo, labels = dados$label)
grupos_minimos <- cutree(model_minimo, k=2)
grupos_minimos

plot(c(-3,3), c(-3,3), type = "n")
for (j in 1:length(dados$x)) {
  if(grupos_minimos[j] == 1){
    points(dados$x[j], dados$y[j], pch = 16, type = "p", col = "red")
  }else{
    points(dados$x[j], dados$y[j], pch = 16, type = "p", col = "blue")
  }
}

model_maximo <- hclust(matriz_minimo, method = "complete")

grupos_maximos <- cutree(model_maximo, k=2)

plot(c(-3,3), c(-3,3), type = "n")
for (j in 1:length(dados$x)) {
  if(grupos_maximos[j] == 1){
    points(dados$x[j], dados$y[j], pch = 16, type = "p", col = "red")
  }else{
    points(dados$x[j], dados$y[j], pch = 16, type = "p", col = "blue")
  }
}

####################
#escala
####################

#a seguir, um caso para exemplificar a importância de realizar uma mudança de escala nos dados ()

pessoas <- c("A", "B", "C", "D")
idade <- c(35, 40, 35, 40)
altura_cm <- c(190, 190, 160, 160) 
altura_m <- altura_cm/100

dados <- data.frame(pessoas, idade, altura_cm, altura_m)
dados
plot(dados$idade, dados$altura_cm, type = "n", asp = 1)

text(altura_cm ~ idade, labels=pessoas, data=dados)

plot(dados$idade, dados$altura_m, type = "n", asp = 1)
text(altura_m ~ idade, labels=dados$pessoas, data=dados)

