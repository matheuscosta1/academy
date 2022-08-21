#o problema do amigo oculto
sorteio <- sample(1:4, size = 4, replace = FALSE) #realizando o amigo oculto com 4 pessoas
any(sorteio == 1:4) #se TRUE, então o amigo oculto deu errado.

#a seguir, vamos estimar a probabilidade de um amigo oculto com 20 pessoas dar certo; primeiro vamos, estimar a probabilidade do amigo dar errado; depois subtraímos 1 dessa estimativa para obtermos a quantidade desejada.
errado <- c()
for (j in 1:100000) {
  sorteio <- sample(1:20, size = 20, replace = FALSE)
  errado[j] <- any(sorteio == 1:20)
}

estimativa <- 1 - mean(errado) #estimativa da probabilidade do amigo dar certo
estimativa

#análise da convergência
media_acumulada <- cumsum(errado)/1:100000
plot(1:100000, media_acumulada, type = "l")