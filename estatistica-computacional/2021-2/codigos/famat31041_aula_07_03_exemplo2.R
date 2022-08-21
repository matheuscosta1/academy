library(readJPEG)
library(dplyr)
library(ggplot2)
# a imagem da arara encontra-se na pasta geral.

imagem <- readJPEG("arara.jpeg")

imagemRGBdata <- data.frame(
  x = rep(1:dim(imagem)[2], each = dim(imagem)[1]),
  y = rep(dim(imagem)[1]:1, dim(imagem)[2]),
  R = as.vector(imagem[,, 1]),
  G = as.vector(imagem[,, 2]),
  B = as.vector(imagem[,, 3]))


k <-  4# especifique o valor de k
kMeans <- kmeans(imagemRGBdata[, c("R", "G", "B")], centers = k)

imagemRGBdata %>% mutate(kColours = rgb(kMeans$centers[kMeans$cluster,])) %>%
  ggplot(aes(x = x, y = y, color = I(kColours))) +
  geom_point(show.legend = FALSE)

