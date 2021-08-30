{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-deferred-type-errors #-}
{-# OPTIONS_GHC -Wno-deferred-out-of-scope-variables #-}
{-# LANGUAGE TypeOperators #-}
module Root.Src.Exercise where

implementar = error "Implementar"
{- 
Nos seguintes exercícios, implemente suas soluções de forma recursiva
Defina os tipos das funções.
-}


{-
Uma função que calcule x * y

Entrada:
    - x
    - y

Resultado: 
    - x * y

Exemplos:
>>>multiplique 2 3
6
>>>multiplique 3 3
9

>>>multiplique 3 (-3)
-9

>>>multiplique (-3) 3
-9

>>>multiplique (-3) (-3)
9

-}

multiplique :: Int -> Int -> Int
multiplique numero 0 = 0
multiplique numero quantidade
    | quantidade > 0 = numero + multiplique numero (quantidade-1)
    | otherwise = negate(multiplique numero (negate quantidade))

{-
Uma função que calcule a quantidade_vezes-ésima potência de um número x.

Entrada:
    - x: base
    - quantidade_vezes: expoente

Resultado: 
    - x elevado a quantidade_vezes

Exemplos:
>>>potência 2 3
8
>>>potência (-3) 2
9
-}

potência :: Int -> Int -> Int
potência numero 0 = 1
potência numero expoente = numero * potência numero (expoente-1)

{-
Uma função que calcule log base 2 de quantidade_vezes por divisões sucessivas por 2.

Entrada:
    - quantidade_vezes

Resultado: 
    - log_2 (quantidade_vezes)

Exemplos:
>>>logBase2 100
6

>>>logBase2 16
4

-}
logBase2:: Int -> Int
logBase2 1 = 0
logBase2 numero = 1 + logBase2 (numero `div` 2)


{-
Uma função que rotacione os elementos de uma tupla quantidade_vezes vezes.

Entrada:
    - tupla: tupla de 5 inteiros.
    - quantidade_vezes: número de rotações a ser feito. Rotacionar à direita se quantidade_vezes é positivo e a esquerda se quantidade_vezes é negativo.

Resultado: 
    - tupla rotacionado quantidade_vezes vezes.

Exemplos:
>>>rotacionar (1,2,3,4,5) 2
(4,5,1,2,3)
>>>rotacionar (1,2,3,4,5) (-2)
(3,4,5,1,2)
-}

getA (a, _, _, _, _) = a
getB (_, b, _, _, _) = b
getC (_, _, c, _, _) = c
getD (_, _, _, d, _) = d
getE (_, _, _, _, e) = e
 
rotacionar tupla quantidade_vezes
    | quantidade_vezes == 0 = tupla
    | quantidade_vezes > 0 = rotacionar (getE tupla, getA tupla, getB tupla, getC tupla, getD tupla) (quantidade_vezes - 1)
    | otherwise = rotacionar (getB tupla, getC tupla, getD tupla, getE tupla, getA tupla) (quantidade_vezes + 1)



{-
Uma função que jogue fora os caracteres inicias de uma string s até que o restante da string se inicie com um caractere c ou que a string fique fazia.

Entrada:
    - s: string
    - c: caractere.

Resultado: 
    - a string resultante.

Exemplos:
>>>jogarForaAté "Eu quis dizer, você não quis escutar." ','
", voc\234 quantidade_vezes\227o quis escutar."

>>>jogarForaAté "Eu quis dizer, você não quis escutar." 'z'
"zer, voc\234 quantidade_vezes\227o quis escutar."

>>>jogarForaAté "Eu quis dizer, você não quis escutar." 'v'
"voc\234 quantidade_vezes\227o quis escutar."

-}
jogarForaAté:: String -> Char -> String
jogarForaAté string caractere
    | head string == caractere = string
    | otherwise = jogarForaAté (drop 1 string) caractere


{-
Desafio!!

A fórmula de Leibniz para pi (http://en.wikipedia.org/wiki/Leibniz_formula_for_%CF%80)
estabelece que a constante pode ser calculada como a série

pi = (4/1) - (4/3) + (4/5) - (4/7)...

Implemente uma função recursiva que calcule a constante até uma quantidade quantidade_vezes de termos.

Entrada:
    - quantidade_vezes: quantidade de termos

Resultado:
    - pi, calculado com quantidade_vezes passos da série

Exemplos:

>>>piDeLeibniz 1
(2.666666666666667,2)

>>>piDeLeibniz 2
(-4.0,1)

>>>piDeLeibniz 3
(-4.0,1)

>>>piDeLeibniz 2000
(0.0,0)

>>>piDeLeibniz 3000
(0.0,0)

-}

somaSequenciaAteNQuantidade:: Double -> Int -> Int -> Double
somaSequenciaAteNQuantidade pi inicio quantidade_termos
    | inicio == quantidade_termos = pi*4
    | even inicio = somaSequenciaAteNQuantidade (pi - (1/((fromIntegral inicio * 2) + 3))) (inicio+1) quantidade_termos
    | otherwise = somaSequenciaAteNQuantidade (pi + (1/((fromIntegral inicio * 2) + 3))) (inicio+1) quantidade_termos

piDeLeibniz :: Int -> Double
piDeLeibniz quantidade = somaSequenciaAteNQuantidade 1 0 (quantidade-1)
