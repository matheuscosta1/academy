A <- matrix(data = c(1,3,6,2), byrow = TRUE, nrow = 2) #criando uma matriz
A #imprimindo a matriz A
A[2,] #acessando a linha 2 de A
A[,1] #acessando a coluna 2 de A
A[2,1] #acessando o elemento da linha 2 e coluna 1 de A

A[2,2] <- 5 #atribuindo outro valor para o elemento da linha 2 e coluna 2 de A
A

A <- rbind(A, c(10,10)) #adicionando uma linha em A
A

D <- cbind(A, c(7,9, 12)) #adicionando uma coluna à matriz A e guardando a matriz resultante em D
D

colnames(A) <- c("col1", "col2") #dando nomes às colunas de A
A
A[,"col1"]
A[,1]

row.names(A) <- c("linha1", "linha2", "linha3") #dando nomes às linhas de A
A
A["linha2",]
class(A)
class(A[,1])


#funções

#criando uma função que retorna a soma de dois números
soma <- function(x,y){
  return(x + y)
  x*y
}

soma(x = 2, y  = 3)


#criando uma função que lança um dado n vezes e retorna a média dos lançamentos
media <- function(n){
  resultados <- sample(1:6, size = n, replace = TRUE)
  return(mean(resultados))
}

media(50)

#criando uma função que testa se uma matriz é simétrica
teste.simetria <- function(A){
  dimensao <- nrow(A)*ncol(A)
  if(sum(A == t(A)) == dimensao){
    return("a matriz é simétrica")
  }else{
    return("a matriz não é simétrica")
  }
}

B <- A[-3,]
teste.simetria(B)

any(B == t(B))
!(B == t(B))

#data frames

#criando um data frame; matrizes só admitem elementos da mesma classe; um data frame tem a forma de uma matriz mas permite que elementos de diferentes classes.
conjunto.dados <- data.frame(pessoa = c("michael", "jim", "dwight"), altura = c(176, 180, 182), estado.civil = c("solteiro", "solteiro", "solteiro"))

class(conjunto.dados)
conjunto.dados[c(1,3),]
class(conjunto.dados[1,])

conjunto.dados <- rbind(conjunto.dados, c("kevin", 185, "casado"))

conjunto.dados$altura

conjunto.dados$cidade <- c("nova york", "nova jersey", "nova york", "boulder")

conjunto.dados$peso <- as.numeric(conjunto.dados$altura)/2

str(conjunto.dados)

conjunto.dados$altura <- as.numeric(conjunto.dados$altura)
str(conjunto.dados)
