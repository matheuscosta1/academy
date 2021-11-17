#GRUPO
# Nayara Terezinha Nunes -11911BCC006
# Thaynara Silva Pinto - 11711BCC039
# Victor Hugo Marra Araujo - 11721BCC041
# Lucas Marçal Coutinho - 11911BCC012


# Variáveis globais
n <- 10000


# Exercício 1

## N primeiros lançamentos
lancamento_1 <- sample(1:6, size = n, replace = TRUE) 
## N segundos lançamentos
lancamento_2 <- sample(1:6, size = n, replace = TRUE) 
## Soma os N primeiros lançamentos com os N segundos lançamentoa um a um
soma_lancamentos <- lancamento_1 + lancamento_2
## Quais dos N experimentos deram 7 ou 11? (TRUE = 1, FALSE = 0... por isso a soma abaixo funciona)
sete_e_onze <- sum(soma_lancamentos == 7 | soma_lancamentos == 11)
## Calcula a proporção de 'acertos'
sete_e_onze / n



# Exercício 2

## Sorteia uma urna N vezes (5 = Urna I, (1, 4, 6) = Urna II, (2, 3) = Urna III)
dado_escolhe_urna <- sample(1:6, size = n, replace = TRUE) 
## Variável para guardar as N retiradas de bola em cada urna escolhida
bolas_escolhidas <- c()

## Em cada urna escolhida, pegamos uma bola
for(num in dado_escolhe_urna) {
  if(num == 5) {
    ## Urna I
    escolhida_da_vez <- sample(c('preta', 'branca', 'vermelha'), size = 1, prob = c(6/13, 3/13, 4/13))
    bolas_escolhidas <- c(bolas_escolhidas, escolhida_da_vez)
  } else if (num == 1 || num == 4 || num == 6) {
    ## Urna II
    escolhida_da_vez <- sample(c('preta', 'branca', 'vermelha'), size = 1, prob = c(3/10, 5/10, 2/10))
    bolas_escolhidas <- c(bolas_escolhidas, escolhida_da_vez)
  } else {
    ## Urna III
    escolhida_da_vez <- sample(c('preta', 'branca', 'vermelha'), size = 1, prob = c(4/8, 2/8, 2/8))
    bolas_escolhidas <- c(bolas_escolhidas, escolhida_da_vez)
  }
}

## Quais dos N experimentos deram 'vermelha'? (TRUE = 1, FALSE = 0... por isso a soma abaixo funciona)
bolas_vermelhas = sum(bolas_escolhidas == 'vermelha')
## Calcula a proporção de 'acertos'
bolas_vermelhas / n



# Exercício 3

## Contador de vitórias no jogo Craps
vitorias <- 0

## Usa-se Monte Carlo: realiza-se o experimento um grande número de vezes e verifica a proporção dos 'acertos'
for(i in 1:n) {
  ## Primeiro e segundo lançamento
  dados <- sample(1:6, size = 2, replace = TRUE)
  ## Calcula a soma dos dois primeiros lançamentos
  soma_inicial <- sum(dados)
  if(soma_inicial == 7 || soma_inicial == 11) {
    ## Se a soma der 7 ou 11, soma-se uma vitória
    vitorias <- vitorias + 1
  } else if(soma_inicial != 2 && soma_inicial != 3 && soma_inicial != 12) {
    ## Se não perdemos o jogo (a soma não pode dar 2, 3 ou 12), temos uma segunda chance
    repeat { 
      ## Os dados devem ser lançados até que a soma dê 7 ou novamente o volor da soma inicial
      dados <- sample(1:6, size = 2, replace = TRUE)
      nova_soma = sum(dados)
      if(nova_soma == 7) {
        ## Se a nova soma der 7, perdemos
        break
      } else if (nova_soma == soma_inicial) {
        ## Se a nova soma der a soma inicial, soma-se uma vitória 
        vitorias <- vitorias + 1
        break
      }
    }
  }  
}

## Calcula-se a proporção de vitórias entre todos os experimentos
vitorias / n



# Exercício 4

## Sequência escolhida por Bran
bran <- c(0, 1, 0)
## Sequência escolhida por Arya
arya <- c(0, 0, 1)

## Array para armazenar os resultados
bran_vs_aria <- c()
## Via Monte Carlo,  realizar o experimento um número grande de vezes
for(i in 1:n) {
  ## De cara, sorteia-se os três primeiros valores da sequência
  sequencia <- sample(0:1, size = 3, replace = TRUE)
  while (TRUE) {
    ## Se os três últimos elementos da sequência forem iguais aos escolhidos por Bran ou Arya, para
    if(sum(bran == sequencia[(length(sequencia) - 2) : length(sequencia)]) == 3) {
      break
    } else if(sum(arya == sequencia[(length(sequencia) - 2) : length(sequencia)]) == 3) {
      break
    }
    ## Se os três últimos elementos da sequência forem diferentes dos escolhidos, adiciona mais um elemento no final e realiza novamente o teste
    sequencia <- c(sequencia, sample(0:1, size = 1, replace = TRUE))
  }
  
  ## Foi o Bran que venceu?
  if(sum(bran == sequencia[(length(sequencia) - 2) : length(sequencia)]) == 3) {
    ## Se sim, adiciona Bran no array de resultados
    bran_vs_aria <- c(bran_vs_aria, 'bran')
  } else {
    ## Se não, adiciona Arya no array de resultados
    bran_vs_aria <- c(bran_vs_aria, 'arya')
  }
}

## Conta quantas vezes a Arya ganhou
vencedor_stark <- sum(bran_vs_aria == 'arya')
## Calcula a proporção de vezes em que a Arya ganhou
vencedor_stark / n



# Exercício 5

## Letra A

### Apesar desse Yoda ser muito suspeito, concordo com ele.
### Como Luke está partindo da origem, o único jeito de ele voltar para ela novamente é ele andar para a esquerda a mesma quantidade que andar para a direita (os passos se anulam).
### Suponha que:
### #D: Quantidade de passos para a direita
### #E: Quantidade de passos para a esquerda
### N: Quantidade total de passos
### #D = #E (Luke dá para a direita e esquerda a mesma quantidade de passos)
###    N = #D + #E (Quantidade de passos)
### -> N = #D + #D (Como são o mesmo valor, é permitida a substituição)
### -> N = 2 * #D (2 vezes qualquer número é um número par, provando que para Luke voltar à origem é necessário que o número de passos dados seja par)

## Letra B

## Suponha:
## D = +1
## E = -1
## Para Like conseguir voltar a origem, a soma dos passos deve ser 0

## Função para calcular a probabilidade de Luke conseguir voltar para a origem
lukeContraMonteCarlo <- function (k) {
  ## Considere K como o número de passos dados
  
  ## Contador de quantas vezes Luke conseguiu voltar para a origem
  luke_na_origem_da_forca <- 0
  
  ## Via Monte Carlo, Luke se vê no centro das Forças negativas e positivas da reta N vezes
  for(i in 1:n) {
    ## Luke dá K passos
    passos_luke = sample(c(1,-1), size = k, replace = TRUE)
    ## Soma os passos da direita com os da esquerda
    soma_passos_luke = sum(passos_luke)
    ## Luke parou na origem? 
    if (soma_passos_luke == 0){
      ## Se sim, incrementa o contador
      luke_na_origem_da_forca <- luke_na_origem_da_forca + 1
    }
  }
  
  return (luke_na_origem_da_forca / n)
}

### I)

lukeContraMonteCarlo(4)

### II)

lukeContraMonteCarlo(6)

### III)

lukeContraMonteCarlo(10)

### IV)

lukeContraMonteCarlo(20)



# Exercício 6

# Vamos aproximar o resultado de integrais por meio de Monte Carlo através da média da aplicação da função em valores aleatórios dentro do intervalo de integração

estimaIntegral <- function(int_inf, int_sup, funcG) {
  ### Sorteia números de -1 a 2 (intervalo de integração)
  nums_sorteados <- runif(n, int_inf, int_sup)
  
  ### Aplicamos G aos números sorteados dentro do intervalo de integração
  resultados_funcao <- funcG(nums_sorteados)
  
  ### Média dos resultados da função
  media_funcao <-(sum(resultados_funcao) / n)
  
  ### Normalizando resultado
  resultado <- abs(int_sup - int_inf) * media_funcao
  
  return(resultado)
}

## Integral de -1 até 2 de ((1 * e^((-x^2)/2))/sqrt(2 * PI))

### Função dentro da integral
g <- function(x) {
  return((1 * exp(1)^(-(x ^ 2)/2))/sqrt(2 * pi))
}

estimaIntegral(-1, 2, g)

## Integral de 0 até PI de (cos^2(x))

### Função dentro da integral
g <- function(x) {
  return((cos(x)) ^ 2)
}

estimaIntegral(0, pi, g)



# Exercício 7

## Função que estima a probabilidade de uma variável aleatória X ser 2: 
## P (X = 1) = 1/3 e P (X = 2) = 2/3.
calculaProporcaoX <- function(k) {
  ## Sorteia números entre 0 e 1
  xs <- runif(k, 0, 1)
  ## Calcula quantos valores caíram em 2/3 do intervalo
  xs_que_sao_2 <- sum(xs < 2/3)
  ## Calcula a proporção dos valores que assumimos representar P(X = 2)
  proporcao_do_2 <- xs_que_sao_2 / k
  return(proporcao_do_2)
}

## K = 100

calculaProporcaoX(100)

## K = 1000

calculaProporcaoX(1000)

## K = 10000

calculaProporcaoX(10000)



# Exercício 8

## Função para gerar um valor aleatório típico de Y
geraY <- function(p, k) {
  ## Realiza K primeiros lançamentos para saber se já temos k sucessos
  lancamentos <- sample(c(0, 1), size = k, replace = TRUE, prob = c(1 - p, p))
  ## Enquanto não tivermos K sucessos, realizamos mais um lançamento e verificamos novamente
  while(sum(lancamentos) != k) {
    ## Realiza mais um lançamento
    lancamentos <- c(lancamentos, sample(c(0, 1), size = 1, replace = TRUE, prob = c(1 - p, p)))
  }
  ## O resultado é quantos lançamentos foram necessários para obtermos os K sucessos
  resultado <- length(lancamentos)
  
  return(resultado)
}

## Parâmetros dados pela questão
p <- 4/7
k <- 3

## Contador de quantos Ys gerados foram maior que 8 em N experimentos
ys <- 0
## Via Monte Carlo, fazemos N experimentos
for (i in 1:n) {
  ## Gera um valor típico de Y
  y <- geraY(p, k)
  ## Se Y maior que 8, incrementa o contador
  if(y > 8) {
    ys <- ys + 1
  }
}
## Calcula a proporção de Ys maiores que 8 em relação ao N gerados
y_maior_que_8 <- ys / n



# Exercício 9

## Função genérica que calcula a equação do 2º grau
raizesDeX <- function(a, b, c) {
  delta <- (b^2) - 4 * a * c
  
  x <- c()
  if(delta >= 0) {
    x1 <- ((-b) + sqrt(delta)) / (2 * a)
    x2 <- ((-b) - sqrt(delta)) / (2 * a)
    x <- c(x1, x2)
  }
  
  return(x)
}

## Utilizado o Método da Transformação Inversa
## F(x) = y = (x^2 + x) / 2, 0 <= x <= 1
## 2 * y = x^2 + x (INVERSA)... ou x^2 + x - (2 * y) = 0

## Sorteia N Ys
ys <- runif(n, 0, 1)

## Contador de Xs gerados no intervalo 0 <= x <= 1
xs_no_intevalo <- c()
## Confia no Monte Carlo
for (i in 1:n) {
  ## Gera as raízes de X para cada Y
  xs <- raizesDeX(1, 1, -(2 * ys[i]))
  
  ## Se o delta não for negativo, há raízes reais
  if(!is.null(xs)) {
    ## Se as raízes estão dentro do intervalo 0 <= x <= 1, adiciona no array de resultados
    if((0 <= xs[1]) && (xs[1] <= 1)) {
      xs_no_intevalo <- c(xs_no_intevalo, xs[1])
    } else if((0 <= xs[2]) && (xs[2] <= 1)) {
      xs_no_intevalo <- c(xs_no_intevalo, xs[1])
    }
  }
}

## Calcula quantos valores são menores que 0.7
xs_menor_07 <- sum(xs_no_intevalo < 0.7)
## Calcula a proporção dos valores menores que 0.7
proporcao_xs <- xs_menor_07 / n

## Calcula a esperança de X
esperanca <- sum(xs_no_intevalo) / n