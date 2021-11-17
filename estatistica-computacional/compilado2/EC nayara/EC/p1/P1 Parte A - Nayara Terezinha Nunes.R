### P1 - NAYARA TEREZINHA NUNES 11911BCC006
### ESTATISTICA COMPUTACIONAL   28/04/2021
--------------------------------------------------------------------------------
### EXERCICIO 01
estimativaIntegral <- function(a_chao, b_teto) {
  
  ### FUNCAO INTEGRAL  
  f <- function(x) {
    return(exp(2*x + (x^2)))
  }
  ### Sorteia 10000 números dentro do intervalo de integração
  sorteio <- runif(10000, a_chao, b_teto)
  
  ### Média de f aplicado aos números sorteados
  media <- mean(f(sorteio))
  
  ### Normalização do resultado
  resultado <- (abs(a_chao) + abs(b_teto)) * media
  
  return(resultado)
}

## Integral de -1 até 2 de (e^(2x+x^2))
estimativaIntegral(-1, 2)

--------------------------------------------------------------------------------
## EXERCICIO 02
  
album <- function(ns, n) {
  completo <- 0
  
  for (i in 1:10000) {
    figurinhas <- 0
    for (j in 1:10000) {
      figurinhas <- sample(c(ns), size = 1, replace = TRUE)
      if (sum(figurinhas) == ns) {  ##contem todas figurinhas
        completo <- length(figurinhas)
      }
    }
  }
  return(completo/10000)
}


n <- 20
ns <- seq(1:n)

## Esperanca HOPE
album(ns, n)

--------------------------------------------------------------------------------
## EXERCICIO 03

## Dado exercicio
N <- 20 

lukeDePorre <- function (L) {
  ## L Posicao inicial de Luke
  aux <- L
  casa <- 0
  precipicio <- 0
  
  ## MC
  for(i in 1:10000) {
    L <- aux ## Luke volta a L
    # 10000 até ele ganhar ou perder e recomeçar de novo
    
    for (j in 1:10000) {
      passo_luke = sample(c(1,-1), size = 1, replace = TRUE) ###passo a passo

      L <- L + passo_luke ##posicao atual
      
      ## Luke caiu 
      if (L == 0){
        precipicio <- precipicio + 1
        break
      } 
      ## Luke chegou em casa
      if (L == N) {
        casa <- casa + 1
        break
      }
    }
  }
  
  return (precipicio/10000)
}

lukeDePorre(18)
### Resultado ≃ 0.1013

lukeDePorre(10)
### Resultado ≃ 0.5081

lukeDePorre(3)
### Resultado ≃ 0.8518


Luke_no_precipicio  <- c() 

for(i in 1:19) {
  Luke_no_precipicio[i] <- lukeDePorre(i)
}

plot(x = 1:19, y = Luke_no_precipicio, pch = 20)