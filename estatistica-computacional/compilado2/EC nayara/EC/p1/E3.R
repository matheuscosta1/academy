N <- 20 

lukeDePorre <- function (L) {
  ## L Posicao inicial de Luke
  aux <- L
  casa <- 0
  precipicio <- 0
  
  ## MC
  for(i in 1:1000) {
    L <- aux ## Luke volta a L
    # 10000 até ele ganhar ou perder e recomeçar de novo
    
    while (TRUE) {
      passo_luke = sample(c(1,-1), size = 1, replace = TRUE) ###passo a passo
      
      L <- L + passo_luke ##posicao atual
      
      ## Luke caiu 
      if (L == 0) {
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
  
  return (precipicio/1000)
}

Luke_no_precipicio  <- c() 

for(i in 1:19) {
  Luke_no_precipicio[i] <- lukeDePorre(i)
}

plot(x = 1:19, y = Luke_no_precipicio, pch = 20)