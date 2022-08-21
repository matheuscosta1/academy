#simulando uma variável de poisson
lambda <- 1 #vamos simular uma poisson de parâmetro lambda = 1
p_atual <- exp(-lambda) #este aqui é o p0, depois vamos atualizar esta probabilidade.

u <- runif(1) #sorteamos um valor entre zero e um.
#a seguir vamos encontrar em qual intervalo [j-1, j] o número u está.
j <- 0
repeat{
  if(u <= p_atual){
    x <- j
    break
  }else{
    j <- j + 1
    p_atual <- p_atual + exp(-lambda)*(lambda^j)/factorial(j)
  }
}
x


#bombas em londres
x <- c()
lambda <- 537/576 #taxa de bombas por região
for (k in 1:1000000) {
  p_atual <- exp(-lambda)
  u <- runif(1)
  j <- 0
  repeat{
    if(u <= p_atual){
      x[k] <- j
      break
    }else{
      j <- j + 1
      p_atual <- p_atual + exp(-lambda)*(lambda^j)/factorial(j)
    }
  }
}

p_0 <- mean(x == 0) #probabilidade estimada de uma região receber zero bomba
p_0 * 576 #número estimadi de regiões que receberam zero bomba (confira com o valor real)
p_1 <- mean(x == 1)#probabilidade estimada de uma região receber uma bomba
p_1 * 576 #número número estimado de regiões que receberam uma bomba
p_2 <- mean(x == 2)#probabilidade estimada de uma região receber duas bombas
p_2 * 576 #número esperado de regiões que receberam duas bombas

#mortes por coice de cavalo
cavalo
str(cavalo)
mortes <- sum(cavalo$deaths)
mortes
lambda <- mortes/nrow(cavalo) #taxa de mortes por batalhão por ano.
lambda

j <- 0
u <- runif(1)
p_atual <- exp(-lambda)
repeat{
  if(u <= p_atual){
    x <- j
    break
  }else{
    j <- j + 1
    p_atual <- p_atual + exp(-lambda)*(lambda*j)/factorial(j)
  }
}
x

x <- c()
for (k in 1:10000000) {
  j <- 0
  u <- runif(1)
  p_atual <- exp(-lambda)
  repeat{
    if(u <= p_atual){
      x[k] <- j
      break
    }else{
      j <- j + 1
      p_atual <- p_atual + exp(-lambda)*(lambda*j)/factorial(j)
    }
  }
}
x
mean(x == 3)*200 #número estimado do total de observações com registro de 3 mortes
sum(cavalo$deaths == 3) #número real do total de observações com registro de 3 mortes
