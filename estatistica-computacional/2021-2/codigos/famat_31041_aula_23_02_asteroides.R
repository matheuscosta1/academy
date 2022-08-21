lambda <- 100*0.00473 #taxa do número de impactos de asteroides em 100 anos

#vamos gerar um valor de uma variável de poisson com parâmetro lambda dado pelo valor acima
lambda
p_atual <- exp(-lambda)
j <-0
u <- runif(1)
repeat{
  if(u<= p_atual){
    x <- j
    break
  }else{
    j <- j + 1
    p_atual <- p_atual + exp(-lambda)*(lambda**j)/factorial(j)
  }
}
x

#gerando, agora, cem mil valores dessa poisson
x <- c()
for (k in 1:100000){
  p_atual <- exp(-lambda)
  j <-0
  u <- runif(1)
  repeat{
    if(u<= p_atual){
      x[k] <- j
      break
    }else{
      j <- j + 1
      p_atual <- p_atual + exp(-lambda)*(lambda**j)/factorial(j)
    }
  }
}

mean(x == 2) #estimativa da probabilidade de cairem dois asteroides em 100 anos

mean(x >= 2) #estimativa da probabilidade de cairem dois ou mais asteroides em 100 anos


#o tempo entre colisões pode ser modelado a partir de uma distribuição exponencial; abaixo vamos simular o tempo de colisão dos 3 primeiros impactos a partir da simulação de uma distribuição exponencial.

lambda <- 5.11e-7
u <- runif(3)
x <- -(1/lambda)*log(1 - u)
x
cumsum(x)
mean(x)
mean(x > 2)
