{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-deferred-type-errors #-}
module Root.Src.Exercise where

implementar = error "Implementar"

{-
Assim como Bool pode assumir os valores True e False, o tipo Naipe pode assumir um dos valores Copas, Espada, Ouro e Paus, tal que
Copas < Espada < Ouro < Paus

>>>Copas > Espada
False

>>> Espada > Ouro
False

>>> Paus > Copas
True

>>>maiorDeTres Copas Espada Paus
Paus

>>>maiorDeTres Copas Copas Copas
Copas

-}
data Naipe = Copas | Espada | Ouro | Paus deriving (Ord,Eq,Show)

{-
Seja o tipo de dados Carta tupla em que 
 - o primeiro elemento é o valor da carta (1,2,3,4,5,6,7,8,9,10,11,12,13) 
 - o segundo é um Naipe
-}
type Carta = (Int, Naipe)


-- Defina as seguintes funções usando apenas casamento de padrões do lado esquerdo das equações.

{-
Uma função que receba uma carta retorne seu Naipe.

Entrada:
    - c1: carta

Resultado: 
    - naipe da carta

Exemplos:
>>>naipe (1,Ouro)
Ouro
-}
naipe:: Carta -> Naipe
naipe (_, naipe) = naipe


{-
Uma função que receba uma carta retorne seu valor.

Entrada:
    - c1: carta

Resultado: 
    - valor da carta

Exemplos:
>>>valor (1,Ouro)
1
-}
valor:: Carta -> Int
valor (valor, _) = valor


{-
Uma função que receba duas cartas retorne se seus naipes são iguais.

Entrada:
    - c1: carta
    - c2: carta

Resultado: 
    - naipe de c1 igual a naipe de c2?

Exemplos:
>>>naipeIgual (1,Ouro) (2,Ouro)
True
>>>naipeIgual (1,Ouro) (2,Paus)
False
-}

naipeIgual:: Carta -> Carta -> Bool
naipeIgual (_, Ouro) (_, Ouro) = True
naipeIgual (_, Copas) (_, Copas) = True
naipeIgual (_, Paus) (_, Paus) = True
naipeIgual (_, Espada) (_, Espada) = True
naipeIgual (_, _) (_, _) = False

{-
Uma função que receba uma carta e retorne seu valor por extenso.

Entrada:
    - c1: carta

Resultado: 
    - valor de c1 por extenso

Exemplos:
>>>valorPorExtenso (1,Ouro)
"Um"
>>>valorPorExtenso (2,Paus)
"Dois"
>>>valorPorExtenso (12,Ouro)
"Dama"
-}
valorPorExtenso:: Carta -> String
valorPorExtenso (valor, _) =  case valor of 1 -> "Um"
                                            2 -> "Dois"
                                            3 -> "Três"
                                            4 -> "Quatro"
                                            5 -> "Cinco"
                                            6 -> "Seis"
                                            7 -> "Sete"
                                            8 -> "Oito"
                                            9 -> "Nove"
                                            10 -> "Dez"
                                            11 -> "Onze"
                                            12 -> "Dama"

{-
Uma função que receba uma carta e retorne seu naipe por extenso.

Entrada:
    - c1: carta

Resultado: 
    - naipe de c1 por extenso

Exemplos:
>>>naipePorExtenso (1,Ouro)
"Ouro"
>>>naipePorExtenso (2,Paus)
"Paus"
>>>naipePorExtenso (12,Ouro)
"Ouro"
-}

naipePorExtenso:: Carta -> String
naipePorExtenso (_, naipe) =  case naipe of Ouro -> "Ouro"
                                            Paus -> "Paus"
                                            Copas -> "Copas"
                                            Espada -> "Espada"

{-
Uma função que receba três cartas e retorne um booleano dizendo se formam uma sequencia, isto é, se estão
aparecem dentro da seguinte sequência: Copas Espada Ouro Paus Copas Espada 

Entrada:
    - Carta
    - Carta
    - Carta

Resultado: 
    - Estão em sequência?

Exemplos:
>>>sequênciaDeNaipes (1,Paus) (2,Ouro) (7,Copas)
False

>>>sequênciaDeNaipes (1,Paus) (7,Copas) (2,Ouro)
False

>>>sequênciaDeNaipes (1,Paus) (2,Espada) (7,Copas)
False

>>>sequênciaDeNaipes (1,Espada) (2,Copas) (7,Ouro)
False

>>>sequênciaDeNaipes (1,Paus) (7,Copas)  (2,Espada)
True

>>>sequênciaDeNaipes (2,Copas) (1,Espada) (7,Ouro)
True

-}
sequênciaDeNaipes:: Carta -> Carta -> Carta -> Bool
sequênciaDeNaipes (_, Copas) (_, Espada) (_, Ouro) = True
sequênciaDeNaipes (_, Paus) (_, Copas) (_, Espada) = True
sequênciaDeNaipes (_, _) (_, _) (_, _) = False

{-
Uma função que recebe uma data na forma de três inteiros e retorna a da por extenso.

Entrada:
    - Dia
    - Mês
    - Ano

Resultado
    - Data por extenso
    - Quando o dia for 1, usar Primeiro como extenso.

Exemplos:
>>>dataPorExtenso 1 1 2001
"Um de Janeiro de 2001"

>>>dataPorExtenso 10 3 2010
"Dez de Mar\231o de 2010"
-}

nomeDia:: Int -> String
nomeDia dia = case dia of 1 -> "Primeiro"
                          2 -> "Dois"
                          3 -> "Três"
                          4 -> "Quatro"
                          5 -> "Cinco"
                          6 -> "Seis"
                          7 -> "Sete"
                          8 -> "Oito"
                          9 -> "Nove"
                          10 -> "Dez"
                          11 -> "Onze"
                          12 -> "Doze"
                          13 -> "Treze"
                          14 -> "Quatorze"
                          15 -> "Quinze"
                          16 -> "Dezesseis"
                          17 -> "Dezessete"
                          18 -> "Dezoito"
                          19 -> "Dezenove"
                          20 -> "Vinte"
                          21 -> "Vinte e um"
                          22 -> "Vinte e dois"
                          23 -> "Vinte e três"
                          24 -> "Vinte e quatro"
                          25 -> "Vinte e cinco"
                          26 -> "Vinte e seis"
                          27 -> "Vinte e sete"
                          28 -> "Vinte e oito"
                          29 -> "Vinte e nove"
                          30 -> "Trinta"
                          31 -> "Trinta e um"

nomeMes mes = case mes of 1 -> "Janeiro"
                          2 -> "Fevereiro"
                          3 -> "Março"
                          4 -> "Abril"
                          5 -> "Maio"
                          6 -> "Junho"
                          7 -> "Julho"
                          8 -> "Agosto"
                          9 -> "Setembro"
                          10 -> "Outubro"
                          11 -> "Novembro"
                          12 -> "Dezembro"

dataPorExtenso:: Int -> Int -> Int -> String
dataPorExtenso dia mes ano = nomeDia dia ++ " de " ++ nomeMes mes ++ " de " ++ show ano
