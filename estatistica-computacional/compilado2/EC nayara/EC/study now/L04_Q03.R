# Lista 04 - Exercício 03
# Alunos: Pedro Henrique Resende Ribeiro - 12011BCC004
#         Kemuel Santos Peres  - 11811BCC035
#         Nayara Terezinha Nunes - 11911BCC006

# LETRA A - ACRESCENTAR COLUNA INFECTION

# Leitura do arquivo SBI.csv

dados <- read.csv(file = "SBI.csv", header = TRUE, sep = ",")
str(dados)

# Criando a coluna infection

for(i in 1:length(dados$sbi)){
  
  if(dados$sbi[i] == "NotApplicable"){
   
    dados$infection[i] <- "não"
    
  }else{
    
    dados$infection[i] <- "sim"
    
  }
  
}

# Transformado a coluna infection em fator

dados$infection <- as.factor(dados$infection)
str(dados)

# LETRA B - REMOVER COLUNAS X, ID E SBI

dados <- subset(dados, select = -c(X, id, sbi))
str(dados)

# LETRA C - SEPARAR CONJUNTO DE DADOS EM TREINO E TESTE

qtd <- round(nrow(dados) * 0.8) # 80% dos dados
indices <- sample(nrow(dados)) # Embaralha o data frame
dados <- dados[indices, ]
treino <- dados[1:qtd, ]
teste <- dados[(qtd + 1):nrow(dados), ]

# LETRA D - CRIAR ÁRVORE DE DECISÃO

# É necessário ter apenas dados númericos ou factors
treino$sex <- as.factor(treino$sex)
treino$prevAB <- as.factor(treino$prevAB)
teste$sex <- as.factor(teste$sex)
teste$prevAB <- as.factor(teste$prevAB)

library(tree)
tree_01 <- tree(infection ~., data = treino, split = "gini")
# FICA HORRÍVEL COM ESSE AQUI!
plot(tree_01)
text(tree_01, cex = 1)

previsao_01 <- predict(tree_01, newdata = teste[ ,-8], type = "class")
mean(previsao_01 == teste$infection)
table(previsao_01, teste$infection)

library(rpart)
library(rpart.plot)
tree_02 <- rpart(infection ~., data = treino, parms = list(split = 'gini'))
# FICA MUITO MELHOR!
rpart.plot(tree_02)

previsao_02 <- predict(tree_02, newdata = teste[ ,-8], type = "class")
mean(previsao_02 == teste$infection)
table(previsao_02, teste$infection)

# Floresta aleatória

library(randomForest)
rf_dados <- randomForest(infection ~., data = treino)
previsao_03 <- predict(rf_dados, newdata = teste, type = "class")
mean(previsao_03 == teste$infection)
matriz <- table(teste$infection, previsao_03)
matriz
