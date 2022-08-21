mega <- read.csv("mega.csv", header = TRUE)
head(mega)
str(mega)
somas <- c()
medias <- c()
for (i in 1:2389) {
  somas[i] <- mega$bola.1[i] + mega$bola.2[i] + mega$bola.3[i] + mega$bola.4[i] + mega$bola.5[i] + mega$bola.6[i] 
}
medias <- somas/6
hist(medias)

vitoria <- c()
for (i in 1:2389) {
  if(mega$bola.1[i] == 1 || mega$bola.2[i] == 1 || mega$bola.3[i] == 1 || mega$bola.4
     [i] == 1 || mega$bola.5[i] == 1 || mega$bola.6[i] == 1){
    vitoria[i] <- 1
  }else{
    vitoria[i] <- 0
  }
}

media_acumulada <- cumsum(vitoria)/1:2389
plot(1:2389, media_acumulada, type = "l", col = "red")
abline(h = 0.1, col = "green")

frequencia <- c()
for (j in 1:60) {
  vitoria <- c()
  for (i in 1:2389) {
    if(mega$bola.1[i] == j || mega$bola.2[i] == j || mega$bola.3[i] == j || mega$bola.4
       [i] == j || mega$bola.5[i] == j || mega$bola.6[i] == j){
      vitoria[i] <- 1
    }else{
      vitoria[i] <- 0
    }
  }
  frequencia[j] <- mean(vitoria)
}
