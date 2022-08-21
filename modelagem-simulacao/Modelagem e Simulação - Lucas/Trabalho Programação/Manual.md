<center><h3>Trabalho programação - Modelagem e simulação</h3></center>



<right>Nome: Lucas do Nascimento Macedo<br>Nome: Miguel Sanches Rocha</right>



<b>Descrição do Software</b>

<p style= "text-align:justify">O software tem como objetivo realizar simulações usando os modelos de fila M/M/1 e M/M/2. Deste modo, é possível realizar execuções de quatro formas diferentes: Deterministica M/M/1, Determinística M/M/2, Aleatória M/M/1 e  Aleatória M/M/2. Cabe ressaltar que no deterministico os valores de TEC e TS são definidos pelo usuário e, no aleatório, essas variáveis são geradas a partir de funções geradoras de números aleatórios. Para o modelo "aleatório M/M/2", existem três opções de funções geradoras de números aleatórios, sendo elas: Normal, exponencial e poisson. Também é possível definir ou não um tamanho máximo de fila. Ao final da execução, é apresentada uma tabela que contém cada passo da simulação seguido de informações relevantes para a análise do processo como um todo.</p>



<b>Sobre o código</b>

<p style= "text-align:justify">O programa foi feito em linguagem Python utilizando o paradigma orientado a objetos. Ele está dividido em três arquivos, sendo o primeiro o arquivo que contém a função <i>main</i>(função principal), o segundo contendo a classe <i>DeterministicSimulation</i> e por último o terceiro contendo a classe <i>Random_Simulation</i>. Para realizar a execução deste programa, basta executar o arquivo main da seguinte forma:

```bash
python3 main.py
```

 <p style= "text-align:justify">Feito isso, o programa irá indagar o usuário qual método de simulação deseja e, após isso, ele ainda perguntará ao usuário se deseja que a simulação tenha tamanho máximo de fila e por fim, pedirá o tempo de simulação em minutos. Podemos notar isso com a seguinte imagem.</p>



![image-20211031165007872](/home/lucas/Dropbox/UFU/6º Periodo/Modelagem e Simulação/Trabalho Programação/Manual.assets/image-20211031165007872.png)

<b>A execução</b>

<p style= "text-align:justify">Quando executamos esse programa com as informações mostradas na imagem acima, o programa apresentará um resultado semelhante à imagem abaixo:


![image-20211031165331518](/home/lucas/Dropbox/UFU/6º Periodo/Modelagem e Simulação/Trabalho Programação/Manual.assets/image-20211031165331518.png)

