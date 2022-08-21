#vamos estimar a integral da função f(x) = (1/sqrt(2*pi))*exp(-0.5*x^2) no intervalo de zero até 1

densidade_normal <- function(x){
  return(sqrt(1/(2*pi))*exp(-0.5*(x^2)))
}

curve(densidade_normal(x), to = 0, from = 1)

#para isto vamos sortear pontos dentro de um retângulo que contém a curva de f(x) dentro do intervalo [0,1]; observe as variações de intervalo nos pontos x e nos pontos y abaixo. 

x <- runif(10000, min = 0, max = 1)
y <- runif(10000, min = 0, max = sqrt(1/(2*pi)))


#agora, vamos verificar quais pontos estão abaixo da curva da função f(x)

dentro <- y <= densidade_normal(x)
dentro

points(x[dentro], y[dentro], pch = 16, col = "orange")
points(x[!dentro], y[!dentro], pch = 16, col = "blue")

#sabendo que o experimento consiste no sorteio de pontos no retângulo dado pelos limites estabelecidos por x e y acima, então a proporção de pontos que caem abaixo da curva nos dá uma estimativa para a probabilidade de sortear um ponto dentro da curva; como esta probabilidade é (área abaixo da curva)/(área total do retângulo), temos que a área abaixo da curva será igual a proporção de pontos que caem abaixo da curva (mean(dentro)) vezes a área do retângulo (2*sqrt(1/(2*pi))):

(mean(dentro))*(2*sqrt(1/(2*pi))) #volte e faça a estimativa com 100 mil pontos

#vamos  agora estimar a integral de g(x) = (x^2)*exp(x) no intervalo [0,1] utilizando o Método de Monte Carlo; para utilizar este método devemos: (1) escrever a função g(x); (2) sortear uniformemente pontos no intervalo estabelecido pelos limites de integração, nesse exemplo o intervalo é [0,1]; (3) aplicar os pontos encontrados em (2) na função g; (4) fazer a média dos pontos obtidos em (3); (5) multiplicar a média obtida em (4) pelo comprimento do intervalo de integração.

#abaixo, estamos considerando a função g(x)  = (x^2)*exp(x); chamamos a função g de funcaog; o resultado do passo 2 foi guardado no objeto x; o resultado do passo 3, isto é, funcaog(x) foi guardado no objeto g.

funcaog <- function(x){
  return((x^2)*exp(x))
} #passo 1

x <- runif(100000, 0, 1) #passo 2

g <- funcaog(x) #passo 3

media <- mean(g) #passo 4

estimativa_integral <- media * (1- 0)
estimativa_integral

#vamos agora estimar a integral de f(x) = (1/sqrt(2*pi))*exp(-0.5*x^2) no intervalo de -1 até 1

densidade_normal <- function(x){
  return(sqrt(1/(2*pi))*exp(-0.5*(x^2)))
} #passo 1

x <- runif(100000, -1, 1) #passo 2


g <- densidade_normal(x) #passo 3


mean(g)*(1 - (-1)) #passos (4) e (5)
