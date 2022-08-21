#estimando pi por monte carlo

#primeiro para ilustrar o problema, vamos sortear mil pontos dentro do quadrado de lado 2 que está centrado na origem do plano; a variável circulo verificará se o ponto sorteado está dentro do círculo; esses pontos serão "pintados" de laranja.

x <- runif(1000, min = -1, max = 1)
y <- runif(1000, min = -1, max = 1)
circulo <- x^2 + y^2 <= 1 
plot(x, y, type = "n", asp = 1)
points(x[circulo], y[circulo], col = "orange", pch = 20)
points(x[!circulo], y[!circulo], col = "blue", pch = 20)

#agora, vamos estimar a constante pi por monte carlo; vamos reaproveitar o código acima e alterar apenas o número de pontos para a estimativa, isto é, vamos trocar mil por 100 mil.

x <- runif(100000, min = -1, max = 1)
y <- runif(100000, min = -1, max = 1)
circulo <- x^2 + y^2 <= 1 


estimativa <- 4*sum(circulo)/100000
paste("A estimativa para pi é de", estimativa)
paste("O erro da estimativa é de", abs(pi - estimativa))


#vamos fazer uma função cuja entrada seja o número de pontos sorteados e a saída seja a estimativa de pi:

valor.pi <- function(n){
  x <- runif(n, min = -1, max = 1)
  y <- runif(n, min = -1, max = 1)
  circulo <- x^2 + y^2 <= 1
  return(4*sum(circulo)/n)
}
valor.pi(50)
valor.pi(500)
valor.pi(5000)
valor.pi(50000)
valor.pi(500000)
