#gerando um valor da variável discreta X que possui a seguinte lei de
#probabilidade: P(X = 4) = 1/12, P(X = 6) = 3/12, P(X = 21) = 7/12
u <- runif(1)
if(u <= 1/12){
  x <- 4
}else if(u <= 4/12){
  x <- 6
}else{
  x <- 21
}

#gerando 1 milhao de valores de uma variável que assume valores de 1 até 6; cada valor tem probabilidade 1/6; em outras palavras, estamos simulando um dado
x <- c()
for(j in 1:1000000){
  u <- runif(1)
  if(u <= 1/6){
    x[j] <- 1
  }else if(u <= 2/6){
    x[j] <- 2
  }else if(u <= 3/6){
    x[j] <- 3
  }else if(u <= 4/6){
    x[j] <- 4
  }else if(u <= 5/6){
    x[j] <- 5
  }else{
    x[j] <- 6
  }
}

mean(x == 6)
1/6
