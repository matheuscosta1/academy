#### funções

soma <- function(x,y){
  x+y
  }

soma(2,3)

#### a última expressão é retornada

soma_e_multiplica1 <- function(x,y){
   x+y 
   x*y
}

soma_e_multiplica(2,3)

#### você pode forçar o R a retornar um objeto específico

soma_e_multiplica2 <- function(x,y){
  soma <- x+y
  produto <- x*y
  soma_e_produto <- c(soma,produto)
  subtracao <- x-y
  return(soma_e_produto)
}

soma_e_multiplica2(2,3)


##### R tem muitas funções matemáticas básicas já incorporadas que podem ser aplicadas a números e vetores de números

###soma

sum(c(2,3,5))
sum(c(1,2,3),c(4,5))


##### isso faz a mesma coisa, apenas salvando o vetor em um objeto
vec <- c(1,2,3,4,5)
sum(vec)

##### Existem muitas outras funções para fazer matemática básica e estatísticas descritivas

max(vec)
min(vec)
median(vec)
mean(vec)
sd(vec) ###desvio padrão
summary(vec) ### resumo dos quadrantes

##### Outras funções que podem ordenar elementos de um vetor ou fornecer informações sobre o vetor

vec2<-c(2,2,1,3,5)

sort(vec2)
rev(vec2)
table(vec2)
unique(vec2)
length(vec2)

####criando vetores rapidamente
seq(1,5)
seq(1,9,by=2)

rep("a",5)
rep(10,5)
