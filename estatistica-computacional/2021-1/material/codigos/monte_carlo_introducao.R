#vamos usar o m?todo de monte carlo para estimar a probabilidade de se tirar uma soma igual a 8 no lan?amento de dois dados:
dado1 <- sample(1:6, size = 100000, replace = TRUE)
dado2 <- sample(1:6, size = 100000, replace = TRUE)
soma <- dado1 + dado2
deu8 <- soma == 8
sum(deu8)/100000 #estimativa da probabilidade
mean(deu8) #outra forma de calcular a estimativa
mean(deu8) - 5/36 #erro da estimativa; o valor te?rico ? 5/36

#vamos estimar a probabilidade exigida na quest?o 3 da lista 1
urna1 <- c(rep("vermelha", times = 5), rep("branca", times = 3), rep("preta", times = 6))

urna2 <- c(rep("vermelha", times = 2), rep("branca", times = 4), rep("preta", times = 4))

urna3 <- c(rep("vermelha", times = 7), rep("branca", times = 2), rep("preta", times = 4))

bola <- c()
for (i in 1:100000) {
  dado <- sample(1:6, size = 1)
  if(dado == 5){
    bola[i] <- sample(urna1, size = 1)
  }
  else if(dado == 1 | dado == 4){
    bola[i] <- sample(urna2, size = 1)
  }else{
    bola[i] <- sample(urna3, size = 1)
  }
}
estimativa <- mean(bola == "vermelha")
estimativa
