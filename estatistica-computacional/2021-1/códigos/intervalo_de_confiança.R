positivos <- sample(3000:5000, size = 1)
negativos <- sample(3000:5000, size = 1)

populacao <- c(rep("sim", positivos), rep("nao", negativos))#criando uma população com indivíduos pertencentes a duas categorias: sim e não (1 ou zero, sucesso ou fracasso)

populacao <- populacao[sample(length(populacao))] #embaralhando a população
head(populacao)

#nosso objetivo será estimar, a partir de uma amostra de tamanho 500, a proporção de pessoas que pertencem à categoria "sim"

valor_real <- mean(populacao == "sim") #aqui o valor real da proporção; vamos supor que não conhecemos este valor; vamos estimá-lo através de um intervalo de confiança com uma confiança de 95%

amostra <- sample(populacao, size = 500) #amostra de tamanho 500
estimativa <- mean(amostra == "sim") #média da amostra
estimativa
inferior <- estimativa - 1.96*sqrt(estimativa*(1-estimativa)/500)
superior <- estimativa + 1.96*sqrt(estimativa*(1-estimativa)/500)
intervalo <- c(inferior, superior)
intervalo #intervalo de 95% de confiança da amostra para a proporção

#agora, vamos criar 100 intervalos; para isso vamos coletar 100 amostras e, para cada amostra, construíremos um intervalo com 95% de confiança; ao final, representaremos todos os intervalos no mesmo gráfico.
intervalos <- list()
menores <- c()
maiores <- c()
for(i in 1:100){
  amostra <- sample(populacao, size = 500)
  estimativa <- mean(amostra == "sim")
  estimativa
  inferior <- estimativa - 1.96*sqrt(estimativa*(1-estimativa)/500)
  superior <- estimativa + 1.96*sqrt(estimativa*(1-estimativa)/500)
  intervalo <- c(inferior, superior)
  intervalos[[i]] <- intervalo
  menores[i] <- inferior
  maiores[i] <- superior
}
maior <- max(maiores) 
menor <- min(menores)


plot(c(menor, maior), c(1,100), type = "n", xlab = "Intervalo de Confiança", ylab = "i-ésimo intervalo")
erro <- 0
for (j in 1:100) {
  if(intervalos[[j]][1] > valor_real | intervalos[[j]][2] < valor_real){
    points(intervalos[[j]], c(j,j), type = "l", col = "blue")
    erro <- erro + 1
  }else{
    points(intervalos[[j]], c(j,j), type = "l")
  }
}
abline(v = valor_real, col = "red", lwd = 2)
erro #quantidade de intervalos que não "acertaram" o verdadeiro valor da proporção; observe que este valor de erro sempre estará próximo de 5 (100% - confiança = 100% - 95%).
