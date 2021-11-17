# PEDRO HENRIQUE RESENDE RIBEIRO.
# MATRICULA: 12011BCC004
# PRIMEIRA PROVA DE ESTATISTICA COMPUTACIONAL

# QUESTAO 04

resultado <- c()

contador <- 0

soma <- 0

for(i in 1:100000){ # DEVE SER 10 MIL
  
  contador <- 0
  
  soma <- 0
  
  repeat{
    
    u <- runif(1,0,1)
    
    soma <- soma + u
    
    contador <- contador + 1
    
    if(soma > 1){
      
      break
      
    }
    
  }
  
  resultado[i] <- contador
  
}

esperanca <- mean(resultado)

evento <- (resultado == 3)

probabilidade_X3 <- mean(evento)


# QUESTAO 05

baralho <- rep(c(1:13), 4)

sorteio <- c()

resultado <- list()

# SORTEIO DAS CARTAS (100 MIL VEZES)

for(i in 1:100000){
  
  sorteio <- sample(baralho, size = 5, replace = FALSE)
  
  resultado[[i]] <- sorteio
  
}

# LETRA A - 2 CARTAS IGUAIS E 3 DIFERENTES

qtd <- 0

contador <- 0

for(i in 1:100000){
  
  contador <- 0
  
  for(j in 1:13){
  
    if(sum(resultado[[i]] == j) == 2){
      
      contador <- contador + 1
      
    }
    
  }
  
  if(contador == 1){
    
    qtd <- qtd + 1
    
  }
  
}

probabilidade_LA <- qtd / 100000

# LETRA B - 2 PARES

qtd <- 0

for(i in 1:100000){
  
  contador <- 0
  
  for(j in 1:13){
    
    if(sum(resultado[[i]] == j) == 2){
      
      contador <- contador + 1
      
    }
    
  }
  
  if(contador == 2){
    
    qtd <- qtd + 1
    
  }
  
}

probabilidade_LB <- qtd / 100000

# LETRA C - 1 TRINCA E 1 PAR

qtd <- 0

contador_01 <- 0

contador_02 <- 0

for(i in 1:100000){
  
  contador_01 <- 0
  
  contador_02 <- 0
  
  for(j in 1:13){
    
    if(sum(resultado[[i]] == j) == 2){
      
      contador_01 <- contador_01 + 1
      
    }
    
  }
  
  if(contador_01 == 1){
    
    for(j in 1:13){
      
      if(sum(resultado[[i]] == j) == 3){
        
        contador_02 <- contador_02 + 1
        
      }
      
    }
    
  }
  
  if(contador_01 + contador_02 == 2){
    
    qtd <- qtd + 1
    
  }
  
}

probabilidade_LC <- qtd / 100000

# LETRA D - 4 CARTAS IGUAIS

qtd <- 0

for(i in 1:100000){
  
  contador <- 0
  
  for(j in 1:13){
    
    if(sum(resultado[[i]] == j) == 4){
      
      contador <- contador + 1
      
    }
    
  }
  
  if(contador == 1){
    
    qtd <- qtd + 1
    
  }
  
}

probabilidade_LD <- qtd / 100000
