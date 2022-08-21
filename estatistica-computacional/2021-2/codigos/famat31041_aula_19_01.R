#exercício 1, lista 1: calcular P(B|C)
#B = soma par
#C = pelo menos um dos dados foi 5

dado1 <- sample(1:6, size = 100000, replace = TRUE)
dado2 <- sample(1:6, size = 100000, replace = TRUE)

soma_par <- (dado1 + dado2)%% 2 == 0 
mean(soma_par) #estimativa para P(B)
tem_cinco <- (dado1 == 5) | (dado2 == 5)
mean(tem_cinco) #estimativa para P(C)

intersecao <- soma_par & tem_cinco
prob_numerador <- mean(intersecao) #estimativa para P(B interseção C)
prob_denominador <- mean(tem_cinco)
prob_denominador

prob_condicional <- prob_numerador/prob_denominador
prob_condicional

#o problema de monty hall

portas <- 1:3

#simulando um jogo em que o jogador muda de porta; ao final, estimaremos a probabildidade dele ganhar dado que ele trocou de porta.

vitorias <- 0
for(j in 1:1000000){
  premio <- sample(portas, size = 1)
  jogador <- sample(portas, size = 1)
  if(jogador == premio){
    silvio <- sample(portas[!(portas %in% jogador)], size = 1)
  }else{
    silvio <- portas[!(portas %in% c(jogador, premio))]
  }
  escolha_final <- portas[!(portas %in% c(jogador, silvio))]
  vitorias <- vitorias + (escolha_final == premio)
}
vitorias/1000000

#quanto tempo temos que esperar até ganharmos pela primeira vez algum prêmio da mega-sena (4, 5 ou 6 acertos)

bilhete <- sample(1:60, size = 6, replace = FALSE)
sorteio <- sample(1:60, size = 6, replace = FALSE)

sum(sorteio %in% bilhete) >= 4
sorteio
bilhete

#inicialmente, vamos simular o experimento 1 vez apenas, isto é, vamos jogar na mega-sena até ganharmos pela primeira vez.
jogadas <- 0
repeat{
  bilhete <- sample(1:60, size = 6, replace = FALSE)
  sorteio <- sample(1:60, size = 6, replace = FALSE)
  jogadas <- jogadas + 1
  if(sum(sorteio %in% bilhete) >= 4){
    break
  }
}

#agora vamos repetir o experimento acima 10 mil vezes.
resultados <- c()
for(j in 1:10000){
  jogadas <- 0
  repeat{
    bilhete <- sample(1:60, size = 6, replace = FALSE)
    sorteio <- sample(1:60, size = 6, replace = FALSE)
    jogadas <- jogadas + 1
    if(sum(sorteio %in% bilhete) >= 4){
      break
    }
  }
  resultados[j] <- jogadas
}
resultados
mean(resultados) #número de semanas admitindo que jogamos uma vez a cada semana; se dividir o resultado acima por 52, teremos a estimativa em anos; vai ser aproximadamente 43 anos.

