# PEDRO HENRIQUE RESENDE RIBEIRO
# N� MATRICULA: 12011BCC004
# PRIMEIRA PROVA DE ESTAT�STICA COMPUTACIONAL.

# QUESTAO 01

EstimativaIntegral = function(a,b){
  
  constante <- (b - a)
  
  # X ~ U[a,b]
  
  x <- runif(100000, a, b)
  
  fx <- exp((2*x) + (x^2))
  
  integral <- constante * mean(fx)
  
  return(integral)
  
}

EstimativaIntegral(-1,2)

# QUESTAO 02

CompletaAlbum = function(N){
  
  figurinhas <- c(1:N)
  
  resultado <- c()
  
  compradas <- c()
  
  contador <- 0
  
  teste <- 0
  
  for(i in 1:10000){ # 10 MIL PARA O R RODAR MAIS RAPIDO
    
    contador <- 0
    
    compradas <- c()
  
    repeat{
      
      teste <- 0
      
      compradas <- c(compradas, sample(c(1:N), size = 1, replace = TRUE))
      
      contador <- contador + 1
      
      verifica <- figurinhas %in% compradas
      
      for(j in 1:length(verifica)){
        
        if(verifica[j] == FALSE){
          
          teste <- 1
          
        }
        
      }
      
      if(teste == 0){
        
        break
        
      }
      
    }
    
    resultado[i] <- contador
  
  }
  
  menor30 <- (resultado < 30)
  
  P30 <- mean(menor30)
  
  # SEI CALCULAR, MAS NAO SEI IMPRIMIR NO CONSOLE
  
  paste("A probabilidade de ser menor que 30 e: ", P30)
  
  esperanca <- mean(resultado)
  
  return(esperanca)

}

# QUESTAO 03

Passeio = function(N,L){

  moeda <- c(0, 1)
  
  resultado <- c()
  
  posicao <- L
  
  for(i in 1:10){ # 1000 PARA RODAR MAIS RAPIDO
    
    repeat{
      
      lancamento <- sample(moeda, size = 1)
      
      if(lancamento == 0){    
        
        posicao <- posicao + 1
        
      }else{
        
        posicao <- posicao - 1
        
      }
      
      if(L + posicao == 0){
        
        resultado[i] = 0
        break
        
      }else if(L + posicao == N){
        
        resultado[i] = 1
        break
        
      }
      
    }
    
  }

  probabilidade <- mean(resultado == 0)
  
  return(probabilidade)

}

est_passeio <- c()

for(i in 1:19){
  
  est_passeio[i] = Passeio(20,i)
  
}

pos <- c(1:19)
  
plot(pos, est_passeio, type = "l") # Cria um gr�fico de linha
