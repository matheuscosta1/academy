a <- sample(1:365, size = 10, replace = TRUE) #sorteando dez datas de aniversario
duplicated(a) #verificando se duas datas são iguais (duas pessoas fazem aniversario no mesmo dia?)

# vamos agora realizar o experimento acima cem mil vezes e vamos contar quantas vezes obtivemos um resultado com duas datas iguais
contador <- 0
for (i in 1:100000) {
  aniversarios <- sample(1:365, size = 10, replace = TRUE)
  if(sum(duplicated(aniversarios))>0){
    contador <- contador + 1
  }
}

prob_teorica <- 1 - (prod(365:356)/365^10) #valor teorico
prob_experimental <- contador/100000 #valor experimental
erro <- abs(prob_teorica - prob_experimental) #erro na estimativa

#o experimento acima foi feito para um grupo com 10 pessoas; vamos criar agora uma função cuja entrada seja o numero n de pessoas e a saída seja a estimativa de que ao menos duas pessoas façam aniversário no mesmo dia.
prob_aniversario <- function(n){
  contador <- 0
  for (i in 1:100000) {
    aniversarios <- sample(1:365, size = n, replace = TRUE)
    if(sum(duplicated(aniversarios))>0){
      contador <- contador + 1
    }
  }
  return(contador/100000)
}
prob_aniversario(10) #usando a função com n=10.
