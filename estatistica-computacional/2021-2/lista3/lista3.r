## Integrantes:
## Matheus José da Costa          11711BCC008
## Luiz Fellipe Machado Tristão   12011BCC037
## Gustavo Melo do Carmo          11721BCC035

#Questão 01

lancamento1 = sample(1:6, size = 100000, replace = TRUE)
lancamento1

lancamento2 = sample(1:6, size = 100000, replace = TRUE)
lancamento2

somas = lancamento1 + lancamento2
somas

mean(somas == 7 | somas == 11)

#Questão 02

urna1 = c(rep("preta", 8), rep("branca", 3), rep("vermelha", 4))
urna2 = c(rep("preta", 3), rep("branca", 5), rep("vermelha", 7))
urna3 = c(rep("preta", 4), rep("branca", 3), rep("vermelha", 2))
urna4 = c(rep("preta", 2), rep("branca", 1), rep("vermelha", 8))

bolas = c()
for(i in 1:10000) {
  dado1 = sample(1:6, size = 1)
  dado2 = sample(1:6, size = 1)
  
  sum = dado1 + dado2
  
  if(sum < 4) {
    bolas[i] = sample(urna1, size = 1)
  } else if (sum >= 4 && sum < 7) {
    bolas[i] = sample(urna2, size = 1)
  } else if(sum == 7) {
    bolas[i] = sample(urna3, size = 1)
  } else {
    bolas[i] = sample(urna4, size = 1)
  }
}

mean(bolas == "vermelha")

#Questão 03

jogos <- c()

contador_juju <- 0
contador_jorel <- 0

for (i in 1:100000) {
  dinheiro_juju = 18
  dinheiro_jorel = 7
  repeat {
    if(dinheiro_juju == 0 || dinheiro_jorel == 0) {
      break
    }
    
    moeda <- c(0, 1)
    lancamento <- sample(0:1, size = 1)
    
    if(lancamento == 0){
      jogos[i] <- "Juju"
      dinheiro_jorel = dinheiro_jorel - 1
      dinheiro_juju = dinheiro_juju + 1
    }
    else{
      jogos[i] <- "Jorel"
      dinheiro_juju = dinheiro_juju - 1
      dinheiro_jorel = dinheiro_jorel + 1
    }
  }  
}

estimativa_juju_ganhar <- mean(jogos == "Juju")
juju_terminar_sem_dinheiro = 1 - estimativa_juju_ganhar
juju_terminar_sem_dinheiro

#Questão 04

wins = c()

for(i in 1:1000000) {
  d1 = sample(1:6, size = 1)
  d2 = sample(1:6, size = 1)
  soma = d1 + d2
  if(soma == 7 || soma == 11) {
    wins[i] = TRUE
  } else if(soma == 2 || soma == 3 || soma == 12) {
    wins[i] = FALSE
  } else {
    somaInicial = soma
    repeat {
      d1 = sample(1:6, size = 1)
      d2 = sample(1:6, size = 1)
      soma = d1 + d2
      if(soma == 7) {
        wins[i] = FALSE
        break
      } else if(soma == somaInicial) {
        wins[i] = TRUE
        break
      }
    }
  } 
}
mean(wins)

#Questão 05

dwith = c(0, 1, 0)
jim = c(0, 0, 1)

wins = c()
for(i in 1:100000) {
  sequencia = sample(0:1, size = 3, replace=TRUE)
  repeat {
    if(all(sequencia == dwith)) {
      wins[i] = FALSE
      break
    } else if(all(sequencia == jim)) {
      wins[i] = TRUE
      break
    }
    sequencia = c(sequencia[2:3], sample(0:1, size = 1)) 
  }
}
mean(wins)

#Questão 06

lukeNpassos = function(n) {
  positions = c()
  for(cases in 1:100000) {
    pos = 0;
    for(i in 1:n) {
      pos = pos + sample(c(-1, 1), size = 1)
    }
    positions[cases] = pos
  }
  return(mean(positions == 0))
}
# i
lukeNpassos(4)
# ii
lukeNpassos(6)
# iii
lukeNpassos(10)
# iv
lukeNpassos(20)

#Questão 07

funcao1 = function(x) {
  (1/sqrt(2*pi))*exp(-x^2/2)
}
3*mean(funcao1(runif(1000000, min = -1, max = 2)))


funcao2 = function(x) {
  cos(x)^2
}

pi*mean(funcao2(runif(1000000, min = 0, max = pi)))
