#vamos simular agora uma variável X que é contínua; para isso, devemos gerar estes valores de acordo com o pseudo código abaixo:
#1. primeiro, tenha em mãos a função F de distribuição acumulada da variável X;
#2. em seguida, obtenha a inversa da função F;
#3. gere um valor u de runif no intervalo [0,1];
#aplique o valor u na inversa obtida em 2.

#a seguir, vamos gerar um valor de uma variável exponencial de parâmetro lambda.
#a função F de distribuição dessa variável é: F(x) = 1 - exp(-lambda*x).
#para obter a inversa, colocamos y = 1 - exp(-lambda*x) e isolamos o x da função; depois de fazermos isso, obtemos x = -(1/lambda)*log(1 - y); esta é a inversa

#vamos considerar lambda = 1.
lambda <- 1
u <- runif(1) #passo 3
x <- -(1/lambda)*log(1 - u) #passo 4, aplicamos u na inversa, isto é, sibstituímos y por u.

#gerando 100 mil valores dessa variável
x <- c()
lambda <- 1
for (j in 1:100000) {
  u <- runif(1) #passo 3
  x[j] <- -(1/lambda)*log(1 - u)
}