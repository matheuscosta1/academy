#exemplo 1: lançar dois dados; qual a probabilidade da soma das faces superiores ser 3?
#vamos usar o método de monte carlo para estimar esta probabilidade

#se quisermos lançar dois dados, podemos proceder da seguinte forma:
dados <- sample(1:6, size = 2, replace = TRUE)
dados

#para verficarmos se a soma deu 2, podemos proceder assim:
sum(dados) == 3

#para estimarmos a probabilidade da soma ser 3 a partir de monte carlo, devemos realizar os passo anterior muitas vezes; a seguir, vamos repetir o processo acima cem mil vezes; se a soma der 3, retornamos 1; se a soma for um número diferente de 3, retornamos 0; estes valores serão guardados no objeto resultados. veja:

resultados <- c()
for (i in 1:100000) {
  dados <- sample(1:6, size = 2, replace = TRUE)
  if(sum(dados) == 3){
    resultados[i] <- 1 
  }else{
    resultados[i] <- 0
  }
}

#via monte carlo, sabemos que a probabilidade estimada será:
sum(resultados)/100000

#o valor teórico para esta probabilidade é: 2/36 (aproximadamente 0.056)

#exemplo 2: qual a probabilidade de uma amigo oculto com três pessoas dar certo? um amigo oculto dá errado quando uma pessoa tira seu próprio nome.

#podemos modelar o problema da seguinte forma: as três pessoas serão chamadas de 1, 2 e 3; se o sorteio deu  3, 2, 1 então isso significa que a pessoa 1 tirou a pessoa 3, a pessoa 2 tirou seu próprio nome e a pessoa 3 tirou a pessoa 1; consequentemente, este amigo oculto deu errado. se o resultado foi 3, 1, 2 então a pessoa 1 tirou a pessoa 3, a pessoa 2 tirou a pessoa 1 e a pessoa 3 tirou a pessoa 2; este amigo oculto deu certo.

#para estimar a probabilidade solicitada, vamos fazer o sorteio acima muitas vezes. se um sorteio der certo, retornaremos 1, se der errado, retornaremos 0.

#dessa vez, vamos repetir o experimento 1 milhão de vezes

respostas <- c()
for (i in 1:1000000) {
  sorteio <- sample(1:3, size = 3, replace = FALSE) #observe o replace igual a FALSE
  if(any(sorteio == 1:3)){
    respostas[i] <- 0
  }else{
    respostas[i] <- 1
  }
}
sum(respostas)/1000000

#se o amigo oculto fosse com 10 vezes, bastaria trocar os valores iguais a 3 por 10 no código acima:

respostas <- c()
for (i in 1:1000000) {
  sorteio <- sample(1:10, size = 10, replace = FALSE) #observe o replace igual a FALSE
  if(any(sorteio == 1:10)){
    respostas[i] <- 0
  }else{
    respostas[i] <- 1
  }
}
sum(respostas)/1000000

#exemplo 3: há n pessoas em uma sala; qual a probabilidade de que pelo menos duas pessoas façam aniversário no mesmo dia?

#vamos convencionar que a pessoa que faz aniversário em 01 de janeiro faz aniversário no dia 1, que a pessoa que faz aniversário em 02 de janeiro faz aniversário no dia 2, que a pessoa que faz aniversário em 01 de fevereiro faz aniversário no dia 32,..., a pessoa que faz aniversário no dia 31 de dezembro faz aniversário no dia 365 (desconsiderando anos bissextos). assim, considerando uma sala com n = 10 pessoas, podemos "sortear" aniversários para elas da seguinte forma:

aniversarios <- sample(1:365, size = 10, replace = TRUE)

#para saber se há dois números iguais em aniversarios, podemos usar a função duplicated; se no vetor que duplicated retorna existir pelo menos um TRUE, isto significa que pelo menos duas pessoas fazem aniversário no mesmo dia; para verificar se um vetor tem algum TRUE, podemos usar a função any.

any(duplicated(aniversarios))

#como queremos estimar a probabilidade de pelo menos duas pessoas fazerem aniversário no mesmo dia, vamos verificar a condição acima para muitos sorteios de aniversarios (dessa vez, 100 mil); se pelo menos duas pessoas fazem aniversário no mesmo dia, então, retornamos 1; caso contrário, zero.

conclusao <- c()
for (i in 1:100000) {
  aniversarios <- sample(1:365, size = 10, replace = TRUE)
  if(any(duplicated(aniversarios))){
    conclusao[i] <- 1
  }else{
    conclusao[i] <- 0
}
}

#a estimativa será:
sum(conclusao)/100000
