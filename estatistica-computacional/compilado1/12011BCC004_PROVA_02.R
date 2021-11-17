# 2ª Prova de Estatística Computacional
# Aluno: Pedro Henrique Resende Ribeiro - 12011BCC004
# Professor: Pedro Franklin

# Questão 01

# Letra (a) - Leitura do conjunto de dados

aves <- read.table(file = "aves.txt", header = TRUE, sep = ",")

head(aves)
tail(aves)
str(aves)
summary(aves)

# Letra (b) - Embaralhar conjunto de dados

indices <- sample(1:nrow(aves))
aves <- aves[indices, ]
aves

# Letra (c) - Média e desvio padrão para cada localidade

islandia <- aves[aves$local == "islandia", ]
dinamarca <- aves[aves$local == "dinamarca", ]
noruega <- aves[aves$local == "noruega", ]

# mp = média do peso, dpp = desvio padrão do peso
# ma = média do comprimento da asa, dpa = desvio padrão do comprimento da asa

# Cálculo para Islândia

mp_islandia <- mean(islandia$peso)
dpp_islandia <- sd(islandia$peso)

ma_islandia <- mean(islandia$comprimento_asa)
dpa_islandia <- sd(islandia$comprimento_asa)

# Cálculo para Dinamarca

mp_dinamarca <- mean(dinamarca$peso)
dpp_dinamarca <- sd(dinamarca$peso)

ma_dinamarca <- mean(dinamarca$comprimento_asa)
dpa_dinamarca <- sd(dinamarca$comprimento_asa)

# Cálculo para Noruega

mp_noruega <- mean(noruega$peso)
dpp_noruega <- sd(noruega$peso)

ma_noruega <- mean(noruega$comprimento_asa)
dpa_noruega <- sd(noruega$comprimento_asa)

# Os valores obtidos foram:
# mp_islandia = 90.50; dpp_islandia = 8.34; ma_islandia = 22.11; dpa_islandia = 1.99
# mp_dinamarca = 193.39; dpp_dinamarca = 10.09; ma_dinamarca = 37.73; dpa_dinamarca = 1.83
# mp_noruega = 130.56; dpp_noruega = 10.39; ma_noruega = 31.89; dpa_noruega = 2.25

# Comentários
# Através do cálculo da média do peso e do comprimento da asa para cada espécie
# é possível notar que as aves de cada  país possuem pesos diferentes. As aves mais
# leves estão na Islândia, enquanto que as mais pesadas estão na Dinamarca. As aves
# da Noruega possuem um peso intermediário entre as aves dos dois países já citados.
# Considerando que o desvio padrão do peso foi semelhante para todos os 3 locais,
# conclui-se que os dados das aves da Dinamarca possuem uma dispersão menor do que
# das outras duas localidades. O desvio padrão representa cerca de 5,2% do peso médio,
# enquanto que para a Islândia o valor é cerca de 9,2% e para a Noruega 8,0%.
# Além disso, pode-se concluir que calcular a média do peso considerando as 3 localidades
# juntas não fornecerá um valor representativo, pois há essa diferença marcante em
# cada localidade. Para a análise da média do comprimento da asa, um procedimento
# semelhante à análise do peso pode ser feito e as mesmas conclusões são obtidas:
# as aves da Dinamarca apresentam o menor desvio padrão (comparado com o valor médio)
# e também não é recomendado calcular um valor médio para o comprimento da asa
# considerando as três localidades juntas.

# Letra (d) - Gráfico comprimento da asa versus peso

plot(aves$comprimento_asa, aves$peso, type = "n")
points(islandia$comprimento_asa, islandia$peso, col = "blue", pch = 19, cex = 1.5)
points(dinamarca$comprimento_asa, dinamarca$peso, col = "red", pch = 19, cex = 1.5)
points(noruega$comprimento_asa, noruega$peso, col = "green", pch = 19, cex = 1.5)

# Letra (e) - Dividir o conjunto de treino e teste

qtd_treino <- round(nrow(aves) * 0.8) # 80% dos dados
treino <- aves[1:qtd_treino, ]
teste <- aves[(qtd_treino + 1):nrow(aves), ]

# Letra (f) - Árvore de decisão

# Os valores obtidos na letra (c) + análise gráfica
# mp_islandia = 90.50; dpp_islandia = 8.34; ma_islandia = 22.11; dpa_islandia = 1.99
# mp_dinamarca = 193.39; dpp_dinamarca = 10.09; ma_dinamarca = 37.73; dpa_dinamarca = 1.83
# mp_noruega = 130.56; dpp_noruega = 10.39; ma_noruega = 31.89; dpa_noruega = 2.25

arvore = function(asa, peso){
  
  if(asa <= 26){
    
    return("islandia")
    
  }else{
    
    if(asa > 26 & peso <= 160){
      
      return("noruega")
      
    }else{
      
      return("dinamarca")
      
    }
    
  }
  
}

# Letra (g) - Taxa de acerto e matriz de confusão

resultado <- c()

for(i in 1:nrow(teste)){
  
  asa <- teste$comprimento_asa[i]  
  peso <- teste$peso[i]
  
  resultado[i] <- arvore(asa,peso)
  
}

# Porcentagem de acertos
mean(resultado == teste$local)

# Matriz de confusão
table(resultado, teste$local)

# Comentários
# Como os dados podem ser bem separados, criar uma árvore de decisão se torna
# mais simples, pois é possível determinar de forma satisfatória os limites que
# definem cada espécie. Como é possível ver, a porcentagem de acertos para o teste
# realizado foi de 100% e a matriz de confusão ilustra (com zeros nas colunas
# diferentes da diagonal principal) que não ocorreram erros de classificação.
# Conjuntos de dados que possuem informações mais "misturadas", torna o processo
# de criação da árvore de decisão mais complexo.

# Questão 02

# Letra (a) - Divisão do data frame e correlação

aves <- read.table(file = "aves.txt", header = TRUE, sep = ",")

islandia <- aves[aves$local == "islandia", ]
dinamarca <- aves[aves$local == "dinamarca", ]
noruega <- aves[aves$local == "noruega", ]

cor(islandia$comprimento_asa, islandia$peso)   # = 0.9769
cor(dinamarca$comprimento_asa, dinamarca$peso) # = 0.9397
cor(noruega$comprimento_asa, noruega$peso)     # = 0.9212

# Comentário
# A melhor correlação obtida foi para a localidade da Islandia.
# Isso pode ser concluido pelo fato de o índice de correlação r ser o maior dentre os 3

# Letra (b) - Coeficiente angular e linear

coeficientes = function(X,Y){
  
  n <- length(X) # saber o tamanho do vetor
  
  aux_01 <- n * sum(X * Y)
  
  aux_01 <- aux_01 - (sum(X) * sum(Y))
  
  aux_02 <- (n * sum(X * X)) - (sum(X) * sum(X))
  
  m <- aux_01 / aux_02
  
  b <- mean(Y) - m * mean(X)
  
  dados <- c(m,b)
  
  return(dados)
  
}

# Letra (c) - Obtenção da reta para Islândia (melhor conjunto de dados)

X <- islandia$comprimento_asa
Y <- islandia$peso

dados <- coeficientes(X,Y)

NY <- dados[2] * X + dados[1]

plot(X, Y, type = "n")
points(X, Y, pch = 19)
# Faltou plotar a regra de regressão
# Os coeficientes não deram certo

# Letra (d) - Explicação da variação do comprimento da asa

# Comentário
# Considerando que o coeficiente angular é X, uma variação de 0,5 na asa
# produz 0,5 * coeficiente angular no peso










