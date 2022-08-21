##Lista 4
##Integrantes:
##Matheus José da Costa         11711BCC008
##Luiz Fellipe Machado Tristão  12011BCC037
##Gustavo Melo                  11721BCC035

##Questão 01

geraValores = function(n) {
  valores <- c()
  for(i in 1:n) {
    valor <- runif(1)
    if(valor <= 1/3) {
      valores[i] <- 1
    } else {
      valores[i] <- 2
    }
  }
  return(valores)
}
mean(geraValores(100) == 2)
mean(geraValores(1000) == 2)
mean(geraValores(10000) == 2)

##Questão 02

geradorExercicio2 <- function (vetor){
  if(sum(vetor) == 1){
    tamanhoVetor <- length(vetor)
    vetorAleatorio <- runif(tamanhoVetor)
    
    for(iterador in 1:tamanhoVetor){
      if(vetorAleatorio[iterador] <= vetor[iterador]) {
        resultado <- iterador
      }
    }
    return(resultado)
  }else {
    print("Não é possível gerar um valor para probabilidade maior que 1.")
  }
}
vetor <- c(0.3,0.5,0.2)
geradorExercicio2(vetor)

vetor <- c(0.3,0.5,0.3)
geradorExercicio2(vetor)

##Questão 03

inversa <- function(y){
  return ((-1 + sqrt(1+8*y))/2)
}

u <- runif(1)
inversa(u)

geradorExercicio03 <- function(n){
  u <- runif(n)
  return (inversa(u))
}

mean(geradorExercicio03(10000) < 0.7) # P(X < 0.7)
mean(geradorExercicio03(10000)) #E[X]

     