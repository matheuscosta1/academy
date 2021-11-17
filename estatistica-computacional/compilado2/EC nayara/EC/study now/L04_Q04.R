# Lista 04 - Exercício 04
# Alunos: Pedro Henrique Resende Ribeiro - 12011BCC004
#         Kemuel Santos Peres  - 11811BCC035
#         Nayara Terezinha Nunes - 11911BCC006

pinguins <- read.csv(file = "penguins_size.csv", header = TRUE, sep = ",")
str(pinguins)

# LETRA A - CÁLCULO DO PESO MÉDIO, TAMANHO MÉDIO DA ASA E DESVIO PADRÃO

peso_medio <- mean(pinguins$body_mass_g, na.rm = TRUE)
peso_medio
desvio_peso <- sd(pinguins$body_mass_g, na.rm = TRUE)
desvio_peso

asa_media <- mean(pinguins$flipper_length_mm, na.rm = TRUE)
asa_media
desvio_asa <- sd(pinguins$flipper_length_mm, na.rm = TRUE)
desvio_asa

# LETRA B - CÁLCULO DAS VARIÁVEIS ANTERIORES POR ESPÉCIE

# pm = peso médio e dpm = desvio peso médio
# am = asa média e dam = desvio asa média

adelie <- pinguins[pinguins$species == "Adelie", ]
chinstrap <- pinguins[pinguins$species == "Chinstrap", ]
gentoo <- pinguins[pinguins$species == "Gentoo", ]

pm_adelie <- mean(adelie$body_mass_g, na.rm = TRUE)
pm_adelie
dpm_adelie <- sd(adelie$body_mass_g, na.rm = TRUE)
dpm_adelie

am_adelie <- mean(adelie$flipper_length_mm, na.rm = TRUE)
am_adelie
dam_adelie <- sd(adelie$flipper_length_mm, na.rm = TRUE)
dam_adelie

pm_chinstrap <- mean(chinstrap$body_mass_g, na.rm = TRUE)
pm_chinstrap
dpm_chinstrap <- sd(chinstrap$body_mass_g, na.rm = TRUE)
dpm_chinstrap

am_chinstrap <- mean(chinstrap$flipper_length_mm, na.rm = TRUE)
am_chinstrap
dam_chinstrap <- sd(chinstrap$flipper_length_mm, na.rm = TRUE)
dam_chinstrap

pm_gentoo <- mean(gentoo$body_mass_g, na.rm = TRUE)
pm_gentoo
dpm_gentoo <- sd(gentoo$body_mass_g, na.rm = TRUE)
dpm_gentoo

am_gentoo <- mean(gentoo$flipper_length_mm, na.rm = TRUE)
am_gentoo
dam_gentoo <- sd(gentoo$flipper_length_mm, na.rm = TRUE)
dam_gentoo

# COMENTÁRIO
# Com relação ao peso médio, fica evidente que a espécie Gentoo possui
# um peso médio maior do que os das espécies Adelie e Chinstrap. Isso
# faz com que a média de todas as espécies se localize em um valor
# intermediário a 3700 (peso médio das espécies Adelie e Chinstrap) e
# 5076 (peso médio da espécie Gentoo). Calcular a média apenas das
# espécies Adelie e Chinstrap produz um valor mais correto do que o valor
# médio das 3 espécies juntas.
# Com relação ao tamanho médio da asa, pode-se considerar que a média
# conjunta das 3 espécies não produzirá um resultado muito confiável
# pelo fato de que os valores médios para cada espécie são diferentes uns
# dos outros. O tamanho médio da asa para as espécies Adelies e Chinstrap
# se interceptam quando o desvio padrão é considerado, porém o valor para
# a asa da espécie Gentoo fica fora do valor médio das outras duas espécies.

# LETRA C - CÁLCULO DO PESO E DO TAMANHO DA ASA MÉDIO CONSIDERANDO O SEXO

macho <- pinguins[pinguins$sex == "MALE", ]
femea <- pinguins[pinguins$sex == "FEMALE", ]

pm_macho <- mean(macho$body_mass_g, na.rm = TRUE)
pm_macho
dpm_macho <- sd(macho$body_mass_g, na.rm = TRUE)
dpm_macho

am_macho <- mean(macho$flipper_length_mm, na.rm = TRUE)
am_macho
dam_macho <- sd(macho$flipper_length_mm, na.rm = TRUE)
dam_macho

pm_femea <- mean(femea$body_mass_g, na.rm = TRUE)
pm_femea
dpm_femea <- sd(femea$body_mass_g, na.rm = TRUE)
dpm_femea

am_femea <- mean(femea$flipper_length_mm, na.rm = TRUE)
am_femea
dam_femea <- sd(femea$flipper_length_mm, na.rm = TRUE)
dam_femea

# COMENTÁRIO
# Calcular o peso médio avaliando apenas o sexo (macho) não resulta em
# um valor muito confiável. Considerando que o desvio padrão foi de
# aproximadamente 17% do valor do peso médio, pode-se concluir que a
# amostra possui uma grande dispersão. Como já notado, os pinguins da
# espécie Gentoo são mais pesados, contribuindo para o aumento do peso
# médio. Com relação ao valor do tamanho médio da asa, considerando que
# o desvio padrão representa cerca de 7% do valor médio do tamanho da asa,
# percebe-se que a amostra, para este caso, é um pouco menos dispersa.
# Para o peso médio e o tamanho médio da asa para as fêmeas, a conclusão
# é semelhante ao explicado para os machos.

# LETRA D - GRÁFICO DO TAMANHO DA ASA VERSUS PESO

# Identificação de dados inválidos
indices_asa <- is.na(pinguins$flipper_length_mm)
indices_peso <- is.na(pinguins$body_mass_g)

asa <- c()
peso <- c()
j <- 1

# Remoção de dados inválidos
for(i in 1:length(pinguins$species)){
  
  if(indices_asa[i] == FALSE & indices_peso[i] == FALSE){
    
    asa[j] <- pinguins$flipper_length_mm[i]
    peso[j] <- pinguins$body_mass_g[i]
    j <- j + 1
    
  }
  
}

# Neste caso: (somente dados válidos)
# asa = pinguins$flipper_length_mm
# peso = pinguins$body_mass_g
plot(asa, peso, pch = 16)

# LETRA E - CORRELAÇÃO ENTRE TAMANHO DA ASA E PESO

# Neste caso: (somente dados válidos)
# asa = pinguins$flipper_length_mm
# peso = pinguins$body_mass_g
r <- cor(asa, peso)
r

# LETRA F - ANÁLISE DO GRÁFICO E DA CORRELAÇÃO

# COMENTÁRIO
# Pode-se perceber, através do gráfico e do valor de r dado pela função cor
# que existe uma correlação entre o tamanho da asa e o peso dos pinguins e
# que é uma correlação forte, pois r = 0.8712 > 0.75. Além disso, pode-se
# concluir que a correlação é positiva, pois, quando o valor da asa aumenta
# o peso do pinguim também aumenta.

# LETRA G - CRIAÇÃO DA RETA MODELO DE REGRESSÃO LINEAR

# Neste caso: (somente dados válidos)
# asa = pinguins$flipper_length_mm
# peso = pinguins$body_mass_g
fit <- lm(peso ~ asa)
fit

plot(asa, peso, pch = 16, title("Regressão linear simples"))
abline(fit, col = "red", lwd = 2)

# LETRA H - EXPLICAR COEFICIENTE ANGULAR

# COMENTÁRIO
# O coeficiente angular significa o quanto será incrementada a variável
# dependente se a variável independente for incrementada de 1 unidade.
# Neste caso, quando o tamanho da asa aumenta de 1 mm, o peso do
# pinguim é incrementado de aproximadamente 49,5 gramas.

# LETRA I - ESTIMATIVA PARA ASA = 204 MM E 168 MM

min(asa) # min = 172 mm
max(asa) # max = 231 mm

a <- as.numeric(fit$coefficients[1])
b <- as.numeric(fit$coefficients[2])

# Peso médio de um pinguim com asa = 204 mm
peso_204 <- a + b * 204
peso_204

# COMENTÁRIO
# Não é possível estimar o peso de um pinguim que possui uma asa com
# tamanho igual a 168 mm. Isso se deve pelo fato de que o modelo obtido
# tem os dados no intervalo [172,231]. Qualquer valor fora deste intervalo
# não pode ser estimado com confiança.
