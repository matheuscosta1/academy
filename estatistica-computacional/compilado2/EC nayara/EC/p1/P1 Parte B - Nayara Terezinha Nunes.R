### P1 - NAYARA TEREZINHA NUNES 11911BCC006
### ESTATISTICA COMPUTACIONAL   30/04/2021
--------------------------------------------------------------------------------
### EXERCICIO 04

# LETRA A
results <- c()

for (i in 1:10000) {
  num1 <- runif(1,0,1)
  num2 <- runif(1,0,1)
  n <- 2 
  soma <- num1 + num2

  while (soma <= 1) {
    numI <- runif(1,0,1)
    soma <- soma + numI
    n <- n + 1
  }
    
  results[i] <- n
  soma <- 0
}
  
result <- sum(results)/10000
result
  
# LETRA B
p3  <- sum(results == 3) / 10000

--------------------------------------------------------------------------------
### EXERCICIO 05
  
baralho <- rep(c(1:13), 4)
cont <- 0

for (i in 1:100000) {
  
  sorteio <- sample(baralho, size = 5, replace = FALSE)
  igual <- 0
  for (j in 1:5) {
    igual <- 0
    for (k in 1:5) {
      if (sorteio[k] == sorteio[j]) {
        igual <- igual + 1
      }   
    }
    if (igual == 4) {
      cont <- cont + 1 
      break
    }
  }
}

pD  <- cont / 100000
pD