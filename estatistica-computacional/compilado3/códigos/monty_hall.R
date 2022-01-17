#o problema do monty hall: primeiro vamos fazer a simulação do clássico problema com 3 portas; depois vamos considerar o problema com 100 portas

#monty hall com 3 portas
#simulando um jogo apenas
portas <- 1:3
premio <- sample(1:3, size = 1)
jogador <- sample(1:3, size = 1)
if(jogador == premio){
  silvio <- sample(portas[-jogador], size = 1)
}else{
  silvio <- portas[-c(jogador, premio)]
}
escolha_final <- portas[-c(jogador, silvio)] #o jogador troca de porta
escolha_final == premio #se TRUE, o jogador levou o prêmio

#agora, vamos estimar a probabilidade de o jogador levar o prêmio ao trocar de porta; para isso vamos usar o método de monte carlo com 100 mil repetições.
portas <- 1:3
vitorias <- 0
for (j in 1:100000){
  premio <- sample(portas, size = 1)
  jogador <- sample(portas, size = 1)
  if(jogador == premio){
    silvio <- sample(portas[-jogador], size = 1)
  }else{
    silvio <- portas[-c(jogador, premio)]
  }
  escolha_final <- portas[-c(jogador, silvio)]
  vitorias <- vitorias + (escolha_final == premio)
}
vitorias/100000 #estimativa da probabilidade

#monty hall com 100 portas
portas <- 1:100
vitorias <- 0
for (j in 1:100000){
  premio <- sample(portas, size = 1)
  jogador <- sample(portas, size = 1)
  if(jogador == premio){
    silvio <- sample(portas[-jogador], size = 98)
  }else{
    silvio <- portas[-c(jogador, premio)]
  }
  escolha_final <- portas[-c(jogador, silvio)]
  vitorias <- vitorias + (escolha_final == premio)
}
vitorias/100000 #estimativa da probabilidade
