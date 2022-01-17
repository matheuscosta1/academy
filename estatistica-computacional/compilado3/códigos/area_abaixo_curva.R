#calculando a área abaixo da curva de uma função a partir do método de monte carlo
densidade <- function(x){
  return((1/sqrt(2*pi))*exp(-x^2/2))
}
#vamos calcular a área abaixo da curva e dentro do intervalo [0,1] da função densidade definida acima 
curve(densidade(x), from = -4, to = 4) #plotando a curva da função

#a seguir, vamos sortear pontos dentro do retângulo que tem uma lado paralelo ao eixo x variando entre zero e 1 e que tem o outro lado paralelo ao eixo y variando entre zero e 1/sqrt(2*pi)
x <- runif(1000, min = 0, max = 1)
y <- runif(1000, min = 0, max = 1/sqrt(2*pi))
dentro <- y <= densidade(x)
points(x[dentro], y[dentro], pch = 16, col = "blue")
points(x[!dentro], y[!dentro], pch = 16, col = "red")
estimativa_inicial <- (1/sqrt(2*pi))*mean(dentro)
estimativa_inicial
# a estimativa acima foi dada utilizando mil pontos apenas; mil não é um número suficientemente grande para o método de monte carlo neste caso; utilizamos mil apenas para facilitar a visualização das regiões consideradas (região vermelha e região azul)

#vamos, agora, dar uma estimativa mais acurada agora utlizando 100 mil pontos
x <- runif(100000, min = 0, max = 1)
y <- runif(100000, min = 0, max = 1/sqrt(2*pi))
dentro <- y <= densidade(x)
estimativa_final <- (1/sqrt(2*pi))*mean(dentro)
estimativa_final