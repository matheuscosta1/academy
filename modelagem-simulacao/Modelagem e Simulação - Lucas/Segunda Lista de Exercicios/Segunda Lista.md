<center><h3>Segunda Lista de Exercícios</h3></center>

<right>Nome: Lucas do Nascimento Macedo<br>Matrícula: 11811BCC044</right>



<right><b>Questão 1</b></right>

<p style= text-align:justify>Para verificarmos se uma cadeia de markov é ergódica, precisamos analisar primeiro se todos os seus estados são: recorrentes, aperiódicos e comunicáveis. Para melhor visualizar essas caracteristicas iremos desenhar o grafo dessas cadeias, desta forma teremos:</p>

* Cadeia P1

  ![image-20210804113716440](/home/lucas/Dropbox/UFU/6º Periodo/Modelagem e Simulação/Segunda Lista de Exercicios/Segunda Lista.assets/image-20210804113716440.png)

  <p style = text-align:justify>Feito isso, agora iremos verificar se essa cadeia de markov atende todos os requisitos para caracterizarmos de engódica.</p>

  * <b>Ela é recorrente, isso porque:</b>

    * Seja i o estado 0  e j o estado 1, perceba que conseguimos ir de i para j usando o caminho {0, 1} e voltarmos para i usando {1, 0}.

    * Seja i o estado 0  e j o estado 2, perceba que conseguimos ir de i para j usando o caminho {0, 2} e voltarmos para i usando o caminho {2,0}.

    * Seja i o estado 1  e j o estado 0, perceba que conseguimos ir de i para j usando o caminho {1, 0} e voltarmos para i usando o caminho {0, 1}.

    * Seja i o estado 1  e j o estado 2, perceba que conseguimos ir de i para j usando o caminho {1, 0, 2} e voltarmos para i usando o caminho {2, 1}.

    * Seja i o estado 2  e j o estado 0, perceba que conseguimos ir de i para j usando o caminho {2, 0} e voltarmos para i usando o caminho {0, 2}.

    * Seja i o estado 2  e j o estado 1, perceba que conseguimos ir de i para j usando o caminho {2, 1} e voltarmos para i usando o caminho {1, 0, 2}.

        

  * <b>Ela é aperiódica, isso porque:</b>

    * Estando no estado 0 o menor caminho para retornar a esse mesmo estado é {1, 2}, logo K=2, porém existem outros caminhos possivéis que não são multiplos de K.

    * Estando no estado 1 é possível retornar ao mesmo estado em apenas um passo, logo K=1.

    * Estando no estado 2 é possível retirnar ao mesmo estado em apenas um passo, logo K=1.

      

  * <b>Ela é comunicável, isso porque:</b>

    * Seja i o estado 0 e j o estado 1, perceba que conseguimos nos comunicar com j através do caminho {0, 1}.
    * Seja i o estado 0 e j o estado 2, perceba que conseguimos nos comunicar com j através do caminho {0, 2}.
    * Seja i o estado 1 e j o estado 0, perceba que conseguimos nos comunicar com j através do caminho {1, 0}.
    * Seja i o estado 1 e j o estado 2, perceba que conseguimos nos comunicar com j através do caminho {1, 0, 2}.
    * Seja i o estado 2 e j o estado 0, perceba que conseguimos nos comunicar com j através do caminho {2,0}.
    * Seja i o estado 2 e j o estado 1, perceba que conseguimos nos comunicar com j através do caminho {2, 0, 1}.

  <p style = text-align:justify>Portanto concluímos que a cadeia de markov apresentada <b>é ergódica</b>.</p>

* Cadeia P2

  ![image-20210804154938391](/home/lucas/Dropbox/UFU/6º Periodo/Modelagem e Simulação/Segunda Lista de Exercicios/Segunda Lista.assets/image-20210804154938391.png)

  <p style = text-align:justify>Feito isso, agora iremos verificar se essa cadeia de markov atende todos os requisitos para caracterizarmos de engódica.</p>

  * <b>Ela não é recorrente, isso porque:</b>

    * Seja i o estado 0  e j o estado 1, perceba que conseguimos ir de i para j usando o caminho {0, 1} e voltarmos para i usando {1, 2, 1}.
    * Seja i o estado 0  e j o estado 2, perceba que conseguimos ir de i para j usando o caminho {0, 1, 2} e voltarmos para i usando {2, 0}.
    * Seja i o estado 0  e j o estado 3, perceba que conseguimos ir de i para j usando o caminho {0, 1, 3}, <i>porém não conseguimos voltar para i, por esse motivo ela não é recorrente</i>.
    * Seja i o estado 1  e j o estado 0, perceba que conseguimos ir de i para j usando o caminho {1, 2, 0} e voltarmos para i usando {0, 1}.
    * Seja i o estado 1  e j o estado 2, perceba que conseguimos ir de i para j usando o caminho {1, 2} e voltarmos para i usando {2, 1}.
    * Seja i o estado 1  e j o estado 3, perceba que conseguimos ir de i para j usando o caminho {1, 3} porém não é possível fazer a volta.
    * Seja i o estado 2  e j o estado 0, perceba que conseguimos ir de i para j usando o caminho {2, 0} e voltarmos para i usando {0, 1, 2}.
    * Seja i o estado 2  e j o estado 1, perceba que conseguimos ir de i para j usando o caminho {2, 1} e voltarmos para i usando {1, 2}.
    * Seja i o estado 2  e j o estado 3, perceba que conseguimos ir de i para j usando o caminho {2, 1, 3} porém não é possível fazer o caminho de volta.
    * Seja i o estado 3  e j o estado 0, perceba que  não conseguimos ir de i para j usando nenhum caminho existente.
    * Seja i o estado 3  e j o estado 1, perceba que  não conseguimos ir de i para j usando nenhum caminho existente.
    * Seja i o estado 3  e j o estado 2, perceba que  não conseguimos ir de i para j usando nenhum caminho existente.
  
    
  
  * <b>Ela é aperiódica, isso porque:</b>
  
    * Estando no estado 0 é possível retornar ao mesmo estado em apenas um passo, logo K=1.
  
    * Estando no estado 1 o menor caminho para retornar a esse mesmo estado é {1, 2}, logo K=2, porém existem outros caminhos possivéis que não são multiplos de K.
  
    * Estando no estado 2 é possível retornar ao mesmo estado em apenas um passo, logo K=1.
  
    * Estando no estado 3 é possível retornar ao mesmo estado em apenas um passo, logo K=1.
  
      
  
  * <b> Ela não é comunicável, isso porque:</b>
  
    * Seja i o estado 0 e j o estado 1, perceba que conseguimos nos comunicar com j através do caminho {0, 1}.
    * Seja i o estado 0 e j o estado 2, perceba que conseguimos nos comunicar com j através do caminho {0, 1, 2}.
    * Seja i o estado 0 e j o estado 3, perceba que conseguimos nos comunicar com j através do caminho {0, 1, 3}.
    * Seja i o estado 1 e j o estado 0, perceba que conseguimos nos comunicar com j através do caminho {1, 2, 0}.
    * Seja i o estado 1 e j o estado 2, perceba que conseguimos nos comunicar com j através do caminho {1, 2}.
    * Seja i o estado 1 e j o estado 3, perceba que conseguimos nos comunicar com j através do caminho {1, 3}.
    * Seja i o estado 2 e j o estado 0, perceba que conseguimos nos comunicar com j através do caminho {2, 0}.
    * Seja i o estado 2 e j o estado 1, perceba que conseguimos nos comunicar com j através do caminho {2, 1}.
    * Seja i o estado 2 e j o estado 3, perceba que conseguimos nos comunicar com j através do caminho {2, 1, 3}.
    * Seja i o estado 3 e j o estado 0, perceba que a partir desse estado não é possível comunicar com nenhum outro, por esse motivo ela é não comunicável.
    * Seja i o estado 3 e j o estado 1, perceba que a partir desse estado não é possível comunicar com nenhum outro, por esse motivo ela é não comunicável.
    * Seja i o estado 3 e j o estado 2, perceba que a partir desse estado não é possível comunicar com nenhum outro, por esse motivo ela é não comunicável.
  
    Vale ressaltar que como na definição diz que para ser comunicável todos os estados devem ser e como achamos um que não é, isso já fere a definição e nos ajuda a concluir que ela não é comunicável.
    
    
  
  Por tanto concluímos que a cadeia de markov apresentada <b>não é ergódica</b>.
  
  

<right><b>Questão 2</b></right>

<p style= text-align:justify>Para verificarmos se uma cadeia de markov é ergódica, precisamos analisar primeiro se todos os seus estados são: recorrentes, aperiódicos e comunicáveis. Para melhor visualizar essas caracteristicas iremos desenhar o grafo dessas cadeias, desta forma teremos:</p>

* Cadeia P1

  ![image-20210805102755782](/home/lucas/Dropbox/UFU/6º Periodo/Modelagem e Simulação/Segunda Lista de Exercicios/Segunda Lista.assets/image-20210805102755782.png)

  <p style = text-align:justify>Feito isso, agora iremos verificar se essa cadeia de markov atende todos os requisitos para caracterizarmos de engódica.</p>

  * <b>Ela não é recorrente, isso porque:</b>

    * Seja i o estado 0  e j o estado 1, perceba que conseguimos não conseguimos ir do estado 0 para 1, por nehum caminho.

    * Seja i o estado 0  e j o estado 2, perceba que conseguimos conseguimos ir do estado 0 para 2, pelo caminho {0, 2} e voltar pelo caminho {2, 0}.

    * Seja i o estado 1  e j o estado 0, perceba que conseguimos conseguimos ir do estado 1 para 0, pelo caminho {1, 0} porém não há um caminho de volta para o estado de origem.

    * Seja i o estado 1  e j o estado 2, perceba que conseguimos conseguimos ir do estado 1 para 2, pelo caminho {1,2} porém não há um caminho de volta para o estado de origem.

    * Seja i o estado 2  e j o estado 0, perceba que conseguimos conseguimos ir do estado 2 para 0, pelo caminho {2, 0} e voltar pelo mesmo estado de origem através do caminho {0, 2}.

    * Seja i o estado 2 e j o estado 1, perceba que conseguimos não conseguimos ir do estado 2 para 1, por nehum caminho.

      

  * <b>Ela é aperiódica, isso porque:</b>

    * Estando no estado 0 é possível retornar ao mesmo estado em apenas um passo, logo K=1.

    * Estando no estado 1 é possível retornar ao mesmo estado em apenas um passo, logo K=1.

    * Estando no estado 2 é possível retornar ao mesmo estado em apenas um passo, logo K=1.

      

  * <b>Ela não é comunicável, isso porque:</b>

    * Seja i o estado 0 e j o estado 1, perceba que não conseguimos nos comunicar com j por nenhum caminho existente.

    * Seja i o estado 0  e j o estado 2, perceba que conseguimos nos comunicar com o estado  j a partir do caminho {0, 2}.

    * Seja i o estado 1  e j o estado 0, perceba que conseguimos nos comunicar com o estado  j a partir do caminho {1, 0}.

    * Seja i o estado 1  e j o estado 2, perceba que conseguimos nos comunicar com o estado  j a partir do caminho {1, 2}.

    * Seja i o estado 2  e j o estado 0, perceba que conseguimos nos comunicar com o estado  j a partir do caminho {2, 0}.

    * Seja i o estado 2 e j o estado 1, perceba que não conseguimos nos comunicar com j por nenhum caminho existente.

      

  <p style = text-align:justify> Portanto temos que essa cadeia de markov não é recorrente, 
      é aperiódica e não é comunicável. Assim sendo, pela definição temos que ela <b>não é 
      ergódica</b>.</p>

* Cadeia P2

  ![image-20210805141546459](/home/lucas/Dropbox/UFU/6º Periodo/Modelagem e Simulação/Segunda Lista de Exercicios/Segunda Lista.assets/image-20210805141546459.png)

  <p style = text-align:justify>Feito isso, agora iremos verificar se essa cadeia de markov atende todos os requisitos para caracterizarmos de engódica.</p>

  * <b>Ela não é recorrente, isso porque:</b>

    * Seja i o estado 0  e j o estado 1, perceba que  não conseguimos ir de i para j usando nenhum caminho,  por esse motivo já podemos classificar ela como não recorrente, pois fere a definição.

    * Seja i o estado 0  e j o estado 2, perceba que também não conseguimos ir de i para j usando nenhum.

    * Seja i o estado 0  e j o estado 3, perceba que conseguimos ir de i para j usando o caminho {0, 3} e voltarmos para i usando {3,0}.

    * Seja i o estado 1  e j o estado 0, perceba que conseguimos ir de i para j usando o caminho {1, 0} porém não conseguimos para o estado de origem.

    * Seja i o estado 1  e j o estado 2, perceba que conseguimos ir de i para j usando o caminho {1, 2} , porém também nesse caso não é possível voltar para o estado de origem.

    * Seja i o estado 1  e j o estado 3, perceba que conseguimos ir de i para j usando o caminho {1, 3} e não conseguimos voltar para o estado de origem.

    * Seja i o estado 2  e j o estado 0, perceba que conseguimos ir de i para j usando o caminho {2, 0} e não conseguimos fazer o caminho de volta para alcançar o estado de origem.

    * Seja i o estado 2  e j o estado 1, perceba que  não conseguimos ir de i para j usando nenhum  caminho caminho existente.

    * Seja i o estado 2  e j o estado 3, perceba que conseguimos ir de i para j usando o caminho {2, 3} , porém não conseguimos fazer o caminho de volta para a origem.

    * Seja i o estado 3  e j o estado 0, perceba que conseguimos ir de i para j usando o caminho {3, 0} e voltarmos para i usando {0,3}.

    * Seja i o estado 3  e j o estado 1, perceba que não conseguimos ir de i para j usando nemhum caminho existente.

    * Seja i o estado 3  e j o estado 2, perceba que não conseguimos ir de i para j usando  nenhum caminho existente.

      

  * <b>Ela é aperiódica, isso porque:</b>

    * Estando no estado 0 é possível retornar ao mesmo estado em apenas um passo, logo K=1.

    * Estando no estado 1 é possível retornar ao mesmo estado em apenas um passo, logo K=1.

    * Estando no estado 2 é possível retornar ao mesmo estado em apenas um passo, logo K=1.

    * Estando no estado 3 é possível retornar ao mesmo estado em apenas um passo, logo K=1.

      

  * <b>Ela não é comunicável, isso porque:</b>

    * Seja i o estado 0 e j o estado 1, perceba que não conseguimos nos comunicar com j por nenhum caminho existente.

    * Seja i o estado 0 e j o estado 2, perceba que não conseguimos nos comunicar com j por nenhum caminho existente.

    * Seja i o estado 0 e j o estado 3, perceba que conseguimos nos comunicar com j pelo caminho {0,3}.

    * Seja i o estado 1 e j o estado 0, perceba que conseguimos nos comunicar com j pelo caminho {1, 0}.

    * Seja i o estado 1 e j o estado 2, perceba que conseguimos nos comunicar com j pelo caminho {1, 2}.

    * Seja i o estado 1 e j o estado 3, perceba que conseguimos nos comunicar com j pelo caminho {1, 3}.

    * Seja i o estado 2 e j o estado 0, perceba que conseguimos nos comunicar com j pelo caminho {2, 0}.

    * Seja i o estado 2 e j o estado 1, perceba que não conseguimos nos comunicar com j por nenhum caminho existente.

    * Seja i o estado 2 e j o estado 3, perceba que conseguimos nos comunicar com j pelo caminho {2, 3}.

    * Seja i o estado 3 e j o estado 0, perceba que conseguimos nos comunicar com j pelo caminho {3, 0}.

    * Seja i o estado 3 e j o estado 1, perceba que não conseguimos nos comunicar com j por nenhum caminho existente.

    * Seja i o estado 3 e j o estado 2, perceba que não conseguimos nos comunicar com j por nenhum caminho existente.

      

  Portanto concluímos que essa cadeira de markov não é recorrente, é aperiódica  e não é comunicável, logo <b>não é ergótica</b>.

<b>Questão 3</b>

* Seja a cadeia de markov:
  $$
  \left[\begin{array}{cc} \frac23 & \frac13\\\frac12 & \frac12\end{array}\right]
  $$
  Para essa temos as seguintes probabildades de estado estacionário:
  $$
  \left[\begin{array}{cc} \pi_1  & \pi_2\\\end{array}\right] + \left[\begin{array}{cc} \frac23 & \frac13\\\frac12 & \frac12\end{array}\right]
  $$
  Fazendo esse cálculo teremos o seguinte sistema linear:
  $$
  \begin{cases}
  \pi_1 = \frac 2 3 \pi_1 + \frac 1 2 \pi_2\\
  \pi_2 = \frac 1 3 \pi_1 + \frac 1 2 \pi_2\\
  \end{cases}
  $$
  Substituindo a segunda equação por 
  $$
  \pi_1 + \pi_2 = 1
  $$
   Teremos
  $$
  \begin{cases}
  \pi_1 = \frac 2 3 \pi_1 + \frac 1 2 \pi_2\\
  1 = \pi_1 +\pi_2\\
  \end{cases}
  $$
  Assim resolvendo esse sistema teremos:
  $$
  \pi_1 + \pi_2 = 1 \rightarrow \pi_1 = 1-\pi_2 \\
  1 -\pi_2 = \frac 2 3 (1 - \pi_2) + \frac 1 2 \pi_2 \\
  1 -\pi_2 = \frac 2 3 - \frac 2 3\pi_2 + \frac 1 2 \pi_2 \\
  1 -\pi_2 = \frac 2 3 + \frac 1 6 \pi_2 \\
  1 - \frac 2 3 = \frac 1 6 \pi_2 + \pi_2 \\
  \frac 1 3 = \frac 7 6 \pi_2 \\
  \pi_2 = \frac 1 3 . \frac 6 7 \rightarrow \pi_2 = \frac {6}{21}
  $$
  Agora vamos substituir na segunda equação afim de descobrir o valor de pi.
  $$
  1 = \pi_1 + \frac{6}{21} \\
  \pi_1 = 1 - \frac{6}{21} \\
  \pi_1 = \frac{15}{21}
  $$

* Seja a cadeia de markov:

  ​	
  $$
  \left[\begin{array}{cc} 0,8 & 0,2 & 0\\0 & 0,2 & 0,8 \\ 0,8 & 0,2 & 0\end{array}\right]
  $$
  Para essa temos as seguintes probabildades de estado estacionário:
  $$
  \left[\begin{array}{cc} \pi_1  & \pi_2 & \pi_3\\\end{array}\right] + \left[\begin{array}{cc} 0,8 & 0,2 & 0\\0 & 0,2 & 0,8 \\ 0,8 & 0,2 & 0\end{array}\right]
  $$
  Fazendo esse cálculo teremos o seguinte sistema linear:
  $$
  \begin{cases}
  \pi_1 = 0,8 \pi_1 + 0,8 \pi_3\\
  \pi_2 = 0,2 \pi_1 + 0,2 \pi_2 + 0,2 \pi_3\\
  \pi_3 = 0,8 \pi_2 
  \end{cases}
  $$
  Substituindo a segunda equação por
  $$
  \pi_1 + \pi_2  + \pi 3 = 1
  $$
  Teremos:
  $$
  \begin{cases}
  \pi_1 = 0,8 \pi_1 + 0,8 \pi_3\\
  \pi_1 + \pi_2  + \pi_3 = 1 \\
  \pi_3 = 0,8 \pi_2 
  \end{cases}
  $$
  Assim resolvendo esse sistema teremos:
  $$
  \pi_1 + \pi_2+\pi_3 = 1 \\
  \pi_1 = 1 - \pi_2-\pi_3
  $$
  Substituindo na segunda equação
  $$
  1 - \pi_2 - 0,8\pi_2 = 0,8(1-\pi_2 - 0,8\pi_2) + 0,8(0,8\pi2)\\
  1 - \pi_2 - 0,8\pi_2 = 0,8-0,8\pi_2-0,64\pi_2+0,64\pi_2\\
  0,8\pi_2+\pi_2+0,8\pi_2=1-0,8\\
  \pi_2 = 0,2
  $$
  Assim podemos descobrir o outros valores
  $$
  \pi_1 = 1-0,2-0,8(0,2)\\
  \pi_1 = 1-0,16\\
  \pi_1 = 0,84\\\\
  \pi_3= 0,8(0,2)\\
  \pi_3=0,16
  $$



<b>Questão 4</b>

* Para este problema temos a seguinte matriz
  $$
  \left[\begin{array}{cc} 0,9 & 0,1\\0,2 & 0,8\end{array}\right]
  $$
  Para esquações de estado estacionário temos:
  $$
  \left[\begin{array}{cc} \pi_1  & \pi_2\\\end{array}\right] + \left[\begin{array}{cc} 0,9 & 0,1\\0,2 & 0,8\end{array}\right]
  $$
  Criando os sistemas lineares
  $$
  \begin{cases}
  \pi_1 = 0,9 \pi_1 + 0,2 \pi_2\\
  \pi_2 = 0,1 \pi_1 + 0,8 \pi_2\\
  \end{cases}
  $$
  Substituindo a segunda equação por
  $$
  \pi_1 + \pi_2  + \pi 3 = 1
  $$
  Ficando da seguinte forma:
  $$
  \begin{cases}
  \pi_1 = 0,9 \pi_1 + 0,2 \pi_2\\
  1 = \pi_1 +\pi_2\\
  \end{cases}
  $$
  Resolvendo esse sistema linear teremos
  $$
  \pi_1 = 1- \pi2\\
  \\
  1-\pi_2 = 0,9(1-\pi_2) +0,2\pi_2\\
  1-\pi_2 = 0,9 - 0,9\pi_2 +0,2\pi_2\\
  -0,9\pi_2 + 0,2\pi_2+\pi_2 = 1 -0,9\\
  0,3\pi_2 = 0,1\\
  \pi_2 = \frac{0,1}{0,3}\\
  
  \\
  
  \pi_1 = 1- \frac{0,1}{0,3}\\
  \pi_1 = 0,6
  $$
  Dessa forma temos que o lucro será:
  $$
  52.1.0,6.100= 3,466milhões
  $$
  Porém como ele pede o novo lucro então faremos o seguinte cálculo:
  $$
  \pi_1 = \frac {0,2}{0,91.0,2.1} \rightarrow \frac{0,2}{0,29} \rightarrow \pi_1 = 0,69
  $$
  Dessa forma, considerando os gastos com a propaganda o lucro será de
  $$
  52.1.0,69.100-500 = 3.086milhões
  $$
  Porntanto podemos concluímos que a companhia não deve contratar a empresa de propaganda.

<b>Questão 5</b>

* Partindo da resolução do exercício anterior temos que o nosso novo lucro é:
  $$
  52.1.\pi_1.100-500 = 3.086milhões
  $$
  Considerando que o valor de pi está relacionado aos consumidores que trocam o refrigerante devemos calcular novamente esse valor considerando essa condição, assim teremos:
  $$
  \pi_1 = \frac{0,2}{((0,9+x)-0,2-1)} \rightarrow \frac{0,2}{0,3-x}
  $$
  Assim calculando também novamente o lucro teremos:
  $$
  52.1.\frac{0,2}{0,3-x}.100-500 > 3.466milhões
  $$
  Podemos então resolver essa inequação da seguinte forma:
  $$
  \frac{1040}{0,3-x}>3966\\
  \frac{1040}{3966}>0,3-x\\
  -0,26+0,30>x\\
  x>0,04
  $$
  Logo, podemos concluir que a redução mínima para que o lucro seja maior que o já existente deverá ser maior que 4%.





