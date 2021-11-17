### P2 - NAYARA TEREZINHA NUNES 11911BCC006
### ESTATISTICA COMPUTACIONAL   14/06/2021
--------------------------------------------------------------------------------
### EXERCICIO 01 - A

###Dados já estão em escala proporcional cm -> gr vs kg -> l
  
dados_aves <- read.delim("aves.txt", header = TRUE, sep = ",", dec = ".")
str(dados_aves)  #150 obs. of  3 variables

summary(dados_aves)

head(dados_aves)
##  comprimento_asa  peso    local
##          22.03   89.06 islandia
##          24.83  100.49 islandia
##          21.62   87.37 islandia
##          19.47   77.55 islandia
##          23.02   90.96 islandia
##          18.51   73.81 islandia

tail(dados_aves)
## comprimento_asa   peso     local
##           36.21 191.83 dinamarca
##           37.48 191.04 dinamarca
##           37.94 193.13 dinamarca
##           39.43 200.98 dinamarca
##           37.79 197.15 dinamarca
##           39.00 203.56 dinamarca


### EXERCICIO 01 - B

indices <- sample(nrow(dados_aves)) # Embaralha o data frame
dados_random_sorted <- dados_aves[indices, ]
str(dados_random_sorted)

tail(dados_random_sorted)
## comprimento_asa    peso     local
##            22.47  89.61  islandia
##            19.34  75.65  islandia
##            21.18  86.45  islandia
##            30.70 125.78   noruega
##            38.63 192.44 dinamarca
##            20.98  86.22  islandia

head(dados_random_sorted)
## comprimento_asa   peso     local
##          23.35   96.81  islandia
##          37.58  189.85 dinamarca
##          29.30  126.84   noruega
##          28.76  120.18   noruega
##          25.10  103.86  islandia
##          20.55   84.29  islandia

### A ordem dos dados foi alterada aleatoriamente 
### se comparada a ordem no estado inicial de leitura dos dados.


### EXERCICIO 01 - C

islandia <- dados_random_sorted[dados_random_sorted$local == "islandia", ]
noruega <- dados_random_sorted[dados_random_sorted$local == "noruega", ]
dinamarca <- dados_random_sorted[dados_random_sorted$local == "dinamarca", ]

comprimento_asa_islandia <- mean(islandia$comprimento_asa, na.rm = TRUE)
comprimento_asa_islandia
dp_comprimento_asa_islandia <- sd(islandia$comprimento_asa, na.rm = TRUE)
dp_comprimento_asa_islandia

comprimento_asa_noruega <- mean(noruega$comprimento_asa, na.rm = TRUE)
comprimento_asa_noruega
dp_comprimento_asa_noruega <- sd(noruega$comprimento_asa, na.rm = TRUE)
dp_comprimento_asa_noruega

comprimento_asa_dinamarca <- mean(dinamarca$comprimento_asa, na.rm = TRUE)
comprimento_asa_dinamarca
dp_comprimento_asa_dinamarca <- sd(dinamarca$comprimento_asa, na.rm = TRUE)
dp_comprimento_asa_dinamarca

### As aves da Islandia tem menor média de comprimento da asa enquanto a dinamarca possui a maior.
### A Noruega deve possuir maior variedade de comprimentos de asa de aves, pois seu desvio padrão é mais alto.

peso_islandia <- mean(islandia$peso, na.rm = TRUE)
peso_islandia
dp_peso_islandia <- sd(islandia$peso, na.rm = TRUE)
dp_peso_islandia

peso_noruega <- mean(noruega$peso, na.rm = TRUE)
peso_noruega
dp_peso_noruega <- sd(noruega$peso, na.rm = TRUE)
dp_peso_noruega

peso_dinamarca <- mean(dinamarca$peso, na.rm = TRUE)
peso_dinamarca
dp_peso_dinamarca <- sd(dinamarca$peso, na.rm = TRUE)
dp_peso_dinamarca

### As aves da Islandia são menores e isso deve ter relação com a menor média de comprimento da asa.
### Assim como a Dinamarca possui maior média de peso e maior comprimento da asa possui.
### A Noruega deve possuir maior variedade de aves, pois mantém o desvio padrão também no peso.


### EXERCICIO 01 - D
plot(islandia$comprimento_asa, islandia$peso, type = "p", col = "red", xlab = "comprimento asa", ylab = "peso", main = "P2")
plot(dinamarca$comprimento_asa, dinamarca$peso, type = "p", col = "blue", xlab = "comprimento asa", ylab = "peso", main = "P2")
plot(noruega$comprimento_asa, noruega$peso, type = "p", col = "green", xlab = "comprimento asa", ylab = "peso", main = "P2")

## Não consegui deixar no mesmo gráfico  :(
plot(islandia$comprimento_asa, islandia$peso, type = "n", col = "red", xlab = "comprimento asa", ylab = "peso", main = "P2")
points(dinamarca$comprimento_asa, dinamarca$peso, type = "p", col = "blue")
points(noruega$comprimento_asa, noruega$peso, type = "n", pch=16, col = "black")

### EXERCICIO 01 - E

qtd <- round(nrow(dados_random_sorted) * 0.8) # 80% dos dados
treino <- dados_random_sorted[1:qtd, ]
teste <- dados_random_sorted[(qtd + 1):nrow(dados_random_sorted), ]

treino
teste

### EXERCICIO 01 - F

classificacao = function(input){
  if(input[1] >= 18 && input[1] < 27 && input[2] >= 70 && input[2] < 110){
    return("Islandia")
  }else{
    if(input[1] >= 28 && input[1] < 40 && input[2] >= 110 && input[2] < 160){
      return("Noruega")
    }else{
      if(input[1] >= 32 && input[1] < 60 && input[2] >= 160 && input[2] < 220){
        return("Dinamarca")
      }else{
       return("Origem do objeto voador não foi identificada, procure no Brasil!")
      }
    }
  }
}
  

## comprimento asa e peso
input <- c(30, 120)
input2 <- c(2, 0)

result = classificacao(input)
result
result = classificacao(input2)
result


### EXERCICIO 02 - A

islandia <- dados_random_sorted[dados_random_sorted$local == "islandia", ]
noruega <- dados_random_sorted[dados_random_sorted$local == "noruega", ]
dinamarca <- dados_random_sorted[dados_random_sorted$local == "dinamarca", ]

r_islandia <- cor(islandia$comprimento_asa, islandia$peso)
r_islandia  #0.9769682

r_dinamarca <- cor(dinamarca$comprimento_asa, dinamarca$peso)
r_dinamarca  #0.9397292

r_noruega <- cor(noruega$comprimento_asa, noruega$peso)
r_noruega  #0.9212377

### As variaveis são mais correlacionadas na Islandia onde há menos variedade.
### E estão mais relacionadas na Noruega onde existe maior variedade de aves, como analisado anteriormente.

