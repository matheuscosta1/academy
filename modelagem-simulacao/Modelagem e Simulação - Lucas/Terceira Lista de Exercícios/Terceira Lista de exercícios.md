<center><h3>Terceira Lista de exercícios</h3></center>



<right>Nome: Lucas do Nascimento Macedo<br>Matrícula: 11811BCC044</right>



<right><b>Questão 1</b></right>

* <b>A</b>
  $$
  t= 2
  \lambda = 30t \rightarrow \lambda = 60 \\ \\
  P(x=60) = \frac{30^{60}e^{-60}}{60!} \rightarrow 0,051
  $$

* <b>B</b>

  Se lambda é igual a 30 pedidos por hora  e t é igual a 4 horas, então a média é de 120 pedidos. O desvio padrão é:
  $$
  120^{\frac{1}{2}} = 10,98
  $$

* C

  Seja x  é o tempo entre os pedidos sucessivos. A média de pedidos por minuto é exponencial com parâmetro 0,5. Assim, a função de probabilidade do tempo entre os dois pedidos é:

  
  $$
  0,5e^{-0,5t} \\ \\
  
  P(1 \leq x \leq 3) =  \int_{1}^{3} 0,5e^{-0,5t} \,dt \rightarrow 0,38
  $$

<b>Questão 2</b>

Seja
$$
\lambda_j = \lambda(j=0, 1,2...) \\
\pi_i = (\pi_{i-1}, \lambda_{i-1}/\mu_i) \\
\mu_0 = 0\\
\mu_i = \mu, (j=0, 1, 2, 3, ...)
$$
Assim podemos ter a seguinte relação
$$
\pi+1 = \lambda_0\pi_0/\mu_1 \rightarrow \pi_1 = \lambda\pi_0/\mu \\
\pi_2 = \lambda_1\pi_1/\mu_2 \rightarrow \pi_2 = \lambda\pi_1/\mu \rightarrow \pi_2 = \lambda^2\pi_0/\mu^2
$$
Logo teremos:
$$
\pi_j = \lambda^j\pi_0/\mu^j
$$
Definindo que a intensidade de tráfego do sistema de filas é dada por:
$$
\rho = \lambda/\mu \\
\\
\sum_{j=0}^\infty \pi_j = 1 \rightarrow \pi_0(1+\rho+rho^2+...) = 1
$$
Assunmindo que rho está no intervalo entre 0 e 1 podemos então calcular a soma de S.
$$
S +\rho+rho^2+...= 1\\\\
\rho S = \rho +\rho^2+ \rho^3+...\\\\
S-\rho S= 1 \rightarrow S= \frac{1}{(1-\rho)}
$$
Por fim teremos:
$$
\pi_0(1+\rho+rho^2+...)=1 \rightarrow \frac{\pi_0}{1-\rho}=1\\
\pi_0 = (1-\rho)
$$
<b>Questão 3</b>

Para a derivação de L
$$
S' = \sum_{j=0}^{\infty}j\rho^j = \rho+2\rho^2+3\rho^3+...\\
\\
\rho S'= rho^2+2\rho^3+3\rho^4+...\\
\\
Então\\
S' - \rho S' = \rho+\rho^2+... = \frac{\rho}{1-\rho}  \rightarrow S' = \frac{\rho}{(1-\rho)^2}\\
\\
Portanto
\\\\
L= (1-\rho)\sum_{j=0}^{\infty}j\rho^j = (1-\rho)\frac{\rho}{(1-\rho)^2}= \frac{\rho}{(1-\rho)} = \frac{\lambda}{\mu-\lambda}
$$
Para a derivação de Lq
$$
Lq = \sum_{j=1}^\infty (j-1)\pi_j = \sum_{j=1}^\infty j\pi_j - \sum_{j=1}^{\infty}\pi_j \\ \\
\sum_{j=0}^\infty \pi_j = 1

Lq = L - \rho = \frac{\rho^2}{1-\rho}
$$
Para a derivação de Ls
$$
Ls = 0\pi_0 + 1(\pi_1+\pi_2+...) = 1-\pi_0
\\\\
Assim\\
Ls = 1-(1-\rho) = \rho
$$
<b>Questão 4</b>

Para a contratação de 1 atendente
$$
w = \frac{1}{\mu-\lambda} \rightarrow w = \frac{1}{20-10} \rightarrow \frac{1}{10}\\\\
10w\lambda = 10.\frac{10}{10} \rightarrow 10\\\\

Total = 10+10+4=24
$$
Portanto concluímos que é mais lucrativo o a contratação de um atendente.

Para a contratação de 2 atendentes
$$
w = \frac{1}{\mu-\lambda} \rightarrow w = \frac{1}{17-10} \rightarrow \frac{1}{7}\\\\
10w\lambda = 10.\frac{10}{7} \rightarrow 14,28\\\\

Total = 14,28+12=26,28
$$
Portanto concluímos que contratar dois atendentes se torna menos lucrativo, consequentemente não viável.
