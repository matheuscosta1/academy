<center><h3>Primeira Lista de Exercícios</h3></center>



<right>Nome: Lucas do Nascimento Macedo<br>Matrícula: 11811BCC044</right>



<right><b>Questão 1</b></right>

<p style= 'text-align:justify'>
	<ul style= 'text-align:justify'>
        <li>Durante o período de 62 minutos, o atendente 1 esteve ocupado <i>90,67%</i> do tempo.</li>
        <li>O atendente 2 estava ocupado apenas <i>69,35</i>% do tempo.</li>
        <li>Nove das 26 chegadas(cerca de 35%) tiveram que esperar. O tempo médio de espera para todos os clientes foi de apenas
<i>0,42</i> minutos.</li>
        <li>Aqueles nove que tiveram que esperar só esperaram uma média de <i>1,22</i> minutos, que é um
tempo bastante baixo.</li>
        <li>Em resumo, este sistema parece bem equilibrado. Um servidor não pode atender a todos os clientes e três servidores
provavelmente seria demais. Adicionando um servidor adicional certamente reduziria o tempo de espera para quase <i>0</i>. No
entanto, o custo da espera teria que ser bastante alto para justificar servidor adicional.</li>
    </ul>     
</p>


<right><b>Questão 2</b></right>

* O grafo associado a Cadeia de Markov é:

  ![image-20210727091030098](/home/lucas/Dropbox/UFU/6º Periodo/Modelagem e Simulação/Lista de Exercícios/Primeira Lista.assets/image-20210727091030098.png)

  

* Sejam os estados definidos por:

  Estado 0 - [2, 0, 0]

  Estado 1 - [1, 1, 0]

  Estado 2 - [1, 0, 1]

  Estado 3 - [0, 2, 0]

  Estado 4 - [0, 0, 2]

  Estado 5 - [0, 1, 1]

  <center>Assim montando a matriz markoviana temos</center>

  | Estados | 0    | 1    | 2    | 3    | 4    | 5    |
  | ------- | ---- | ---- | ---- | ---- | ---- | ---- |
  | 0       | 0    | 1/2  | 1/2  | 0    | 0    | 0    |
  | 1       | 0    | 0    | 1/2  | 1/4  | 0    | 1/4  |
  | 2       | 0    | 1/2  | 0    | 0    | 1/4  | 1/4  |
  | 3       | 0    | 0    | 0    | 0    | 0    | 1    |
  | 4       | 0    | 0    | 0    | 0    | 0    | 1    |
  | 5       | 0    | 0    | 0    | 1/2  | 1/2  | 0    |

<right><b>Questão 3</b></right>

* Sejam os estados definidos por:

  Estado 0 - [2, 0, 0]

  Estado 1 - [1, 1, 0]

  Estado 2 - [1, 0, 1]

  Estado 3 - [0, 2, 0]

  Estado 4 - [0, 0, 2]

  Estado 5 - [0, 1, 1]

<center>Assim montando a matriz markoviana temos</center>

| Estados | 0    | 1    | 2    | 3    | 4    | 5    |
| ------- | ---- | ---- | ---- | ---- | ---- | ---- |
| 0       | 0    | 1/2  | 1/2  | 0    | 0    | 0    |
| 1       | 1/4  | 0    | 1/4  | 1/4  | 0    | 1/4  |
| 2       | 1/4  | 1/4  | 0    | 0    | 1/4  | 1/4  |
| 3       | 0    | 1/2  | 0    | 0    | 0    | 1/2  |
| 4       | 0    | 0    | 1/2  | 0    | 0    | 1/2  |
| 5       | 0    | 1/4  | 1/4  | 1/4  | 1/4  | 0    |

* O grafo associado a Cadeia de Markov é:

  ![image-20210727101053929](/home/lucas/Dropbox/UFU/6º Periodo/Modelagem e Simulação/Lista de Exercícios/Primeira Lista.assets/image-20210727101053929.png)

<right><b>Questão 4</b></right>

* Sejam os estados definidos por:

  Estado 0 - [0, 0]

  Estado 1 - [0, 1]

  Estado 2 - [1, 0]

  Estado 3 - [1, 1]

  Onde, 0 significa que a máquina está quebrada e 1 significa que a máquina esta em operação. Desta forma temos a matriz markoviana.

  | Estados | 0    | 1    | 2    | 3    |
  | ------- | ---- | ---- | ---- | ---- |
  | 0       | 0    | 0    | 0    | 1    |
  | 1       | 0    | 0    | 1/3  | 2/3  |
  | 2       | 0    | 1/3  | 0    | 2/3  |
  | 3       | 1/9  | 2/9  | 2/9  | 4/9  |

* O grafo associado a Cadeia de Markov é:

  

  ![image-20210727145218989](/home/lucas/Dropbox/UFU/6º Periodo/Modelagem e Simulação/Lista de Exercícios/Primeira Lista.assets/image-20210727145218989.png)

<right><b>Questão 5</b></right>

Para apresentarmos a matriz markoviana precisamos a princípio definir nossos estados assim temos:

Estado 1 - Dias de Sol

Estado 2 - Dias de chiva

Assim motando nossa matriz de markov temos os seguintes dados:

| Estados | 1    | 2    |
| ------- | ---- | ---- |
| 1       | 0.9  | 0.1  |
| 2       | 0.2  | 0.8  |

Tendo a matriz markoviana montada podemos então apresentar o grafo que está associado e essa matriz. Assim temos ele mostrado abaixo:

![image-20210727151334674](/home/lucas/Dropbox/UFU/6º Periodo/Modelagem e Simulação/Lista de Exercícios/Primeira Lista.assets/image-20210727151334674.png)

<right><b>Questão 6</b></right>

A princípio se faz necessário determinar quais os possíveis estados do sistema. Os estados são dados por um vetor cujo os valores são apresentados abaixo:

Estado 0 - [1, 1]

Estado 1 - [1,2]

Estado 2 - [2, 1]

Estado 3 - [2, 2]

Vale ressaltar que o valor 1 significa sol e o valor 2 significa chuva.

Tendo os estados já definidos, podemos já construir nossa matriz markoviana.

| Estados | 0    | 1    | 2    | 3    |
| ------- | ---- | ---- | ---- | ---- |
| 0       | 0.95 | 0    | 0.05 | 0    |
| 1       | 0.3  | 0    | 0.7  | 0    |
| 2       | 0    | 0,4  | 0    | 0.6  |
| 3       | 0    | 0.2  | 0    | 0.8  |

Após todos os cálculos temos que feita nossa matriz markoviana e a partir dela iremos agora fazer o grafo que esta associado e ela.

![image-20210727155525515](/home/lucas/Dropbox/UFU/6º Periodo/Modelagem e Simulação/Lista de Exercícios/Primeira Lista.assets/image-20210727155525515.png)

<right><b>Questão 7</b></right>

Para desenvolvermos a cadeia de markov precisamos a princípio definir nossos estados, assim seja:

Estado 0 - 0 peças no estoque

Estado 1 - 1 peça no estoque

Estado 2 - 2 peças no estoque

Estado 3 - 3 peças no estoque

Feito isso, abaixo temos desenvolvido a matriz de markov



| Estados | 0    | 1    | 2    | 3    | 4    |
| ------- | ---- | ---- | ---- | ---- | ---- |
| 0       | 0    | 0    | 0    | 0    | 1    |
| 1       | 0    | 0    | 0    | 0    | 1    |
| 2       | 1/3  | 1/3  | 1/3  | 0    | 0    |
| 3       | 0    | 1/3  | 1/3  | 1/3  | 0    |
| 4       | 0    | 0    | 1/3  | 1/3  | 1/3  |

Tendo a matriz de markov, podemos então fazer o seu grafo associado e veremos que o grafo associado e essa matriz é:

![image-20210727161918379](/home/lucas/Dropbox/UFU/6º Periodo/Modelagem e Simulação/Lista de Exercícios/Primeira Lista.assets/image-20210727161918379.png)
