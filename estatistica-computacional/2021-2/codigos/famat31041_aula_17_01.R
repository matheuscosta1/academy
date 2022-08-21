#quantas figurinhas temos que comprar, em média, para completarmos um álbum com 10 figurinhas?

#inicialmente, vamos fazer uma simulação do experimento, isto é, vamos sortear figurinhas até o álbum ficar completo; o número de sorteios até o álbum ser completado estará em j.

figurinhas <- 1:10
album <- sample(figurinhas, size = 10, replace = TRUE)
j <- 10
while(length(unique(album)) < 10){
  album <- c(album, sample(figurinhas, size = 1))
  j <- j + 1
}
print(j)

#agora, vamos replicar o experimento acima 10 mil vezes e calcular a média dos resultados obtidos.
resultados <- c()
for (k in 1:10000) {
  album <- sample(figurinhas, size = 10, replace = TRUE)
  j <- 10
  while(length(unique(album)) < 10){
    album <- c(album, sample(figurinhas, size = 1))
    j <- j + 1
  }
  resultados[k] <- j
}
resultados
mean(resultados)

#o código sobre o cassino está em um texto sobre assunto na pasta texto das aulas.