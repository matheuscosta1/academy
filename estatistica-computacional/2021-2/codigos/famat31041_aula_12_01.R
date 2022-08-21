#vamos estimar a área abaixo da curva x^2 para x maior que zero e x menor do que 1; inicialmente, vamos sortear pontos dentro do retângulo de lados no eixo x em [0,2] e no eixo y em [0,4].

x <- runif(1000, min = 0, max = 2)
y <- runif(1000, min = 0, max = 4)

#agora, vamos verificar quais pontos estão abaixo da curva
dentro <- y <= x^2

plot(x, y, type = "n", asp = 1)
points(x[dentro],y[dentro], pch = 16, col = "blue")
points(x[!dentro], y[!dentro], pch = 16, col = "orange")

mean(dentro) #probabilidade de sortear um ponto no retângulo e que esteja abaixo da curva. para estimarmos a área abaixo da curva, devemos multiplicar está média pela área do retângulo, pois a probabilidade de sortear um ponto nesta região é igual a (área da região abaixo da curva)/(área total do retângulo)

8*mean(dentro) #área da região
#o exemplo acima foi feito apenas sorteando-se mil pontos em x e mil pontos em y; isto foi feito apenas para deixar a imagem dos pontos sorteados mais didática; refaça o experimento com 100000 mil sorteios, por exemplos.

#estimando pi
x <- runif(100000, -1, 1)
y <- runif(100000, -1, 1)
dentro <- x^2 + y^2 <= 1
plot(x, y, type = "n", asp = 1)
points(x[dentro], y[dentro], pch = 16, col = "blue")
points(x[!dentro], y[!dentro], pch = 16, col = "orange")

#a probabilidade P de se sortear um ponto dentro do círculo é igual a (área do círculo)/(área total do quadrado); como a área total do quadrado é 4, então a área do círculo é 4*P; por outro lado a área deste círculo é pi*r^2 = pi*1^2 = pi; logo, pi = 4*P

P<- mean(dentro)
estimativa_pi <- 4*P
estimativa_pi
