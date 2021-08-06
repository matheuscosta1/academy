{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
somaTresNumeros:: Int -> Int -> Int -> Int
somaTresNumeros n1 n2 n3 = n1 + n2 + n3

areaQuadrado:: Float -> Float
areaQuadrado l = l**2

areaRetangulo:: Float -> Float -> Float
areaRetangulo l1 l2 = l1 * l2

maiorDeTres:: Integer -> Integer -> Integer -> Integer
maiorDeTres a b c
  | a >= b && a >= c = a
  | b >= c = b
  | otherwise = c

pedraTesouraPapel :: String -> String -> String
pedraTesouraPapel m1 m2
  | (m1 == "tesoura" && m2 == "papel") || (m2 == "tesoura" && m1 == "papel")  = "tesoura"
  | (m1 == "pedra" && m2 == "tesoura") || (m2 == "pedra" && m1 == "tesoura") = "pedra"
  | (m1 == "papel" && m2 == "pedra") || (m2 == "papel" && m1 == "pedra") = "papel"
  | m1 == m2 = "empate"
  | otherwise = "opcao invalida"

eLógico :: Bool -> Bool -> Bool
eLógico p1 p2 = p1 && p2

ouLógico :: Bool -> Bool -> Bool
ouLógico p1 p2 = p1 || p2

subStringDeAte:: String -> Int -> Int -> String
subStringDeAte string posicao1 posicao2 = take posicao2 (take (posicao1+posicao2) (drop posicao1 string))

ultimosU :: String -> Int -> String
ultimosU string posicao = reverse(take posicao (reverse string ))

subStringDeAteAppend :: String -> String -> Int -> Int -> String
subStringDeAteAppend string1 string2 posicao1 posicao2 = subStringDeAte string1 posicao1 posicao2 ++ subStringDeAte string2 posicao1 posicao2

type Carta = (Int, String)

naipe:: Carta -> String
naipe (_, naipe) = naipe

valor:: Carta -> Int
valor (valor, _) = valor

cartaÉMenor:: Carta -> Carta -> Bool
cartaÉMenor (valor1, naipe1) (valor2, naipe2) = (valor1 < valor2) || (valor1 == valor2 && naipe1 < naipe2)

cartaÉIgual:: Carta -> Carta -> Bool
cartaÉIgual carta1 carta2 = carta1 == carta2

cartaÉMaior:: Carta -> Carta -> Bool
cartaÉMaior carta1 carta2 = carta1 > carta2

maiorCarta:: Carta -> Carta -> Carta -> Carta
maiorCarta carta1 carta2 carta3
  | cartaÉMaior carta1 carta2 && cartaÉMaior carta1 carta3 = carta1
  | cartaÉMaior carta2 carta1 && cartaÉMaior carta2 carta3 = carta2
  | otherwise = carta3

menorCarta:: Carta -> Carta -> Carta -> Carta
menorCarta carta1 carta2 carta3
  | cartaÉMenor carta1 carta2 && cartaÉMenor carta1 carta3 = carta1
  | cartaÉMenor carta2 carta1 && cartaÉMenor carta2 carta3 = carta2
  | otherwise = carta3

cartaMediana:: Carta -> Carta -> Carta -> Carta
cartaMediana carta1 carta2 carta3
  | maiorCarta carta1 carta2 carta3 == carta1 && menorCarta carta1 carta2 carta3 == carta2 = carta3
  | maiorCarta carta1 carta2 carta3 == carta1 && menorCarta carta1 carta2 carta3 == carta3 = carta2
  | maiorCarta carta1 carta2 carta3 == carta2 && menorCarta carta1 carta2 carta3 == carta1 = carta3
  | maiorCarta carta1 carta2 carta3 == carta2 && menorCarta carta1 carta2 carta3 == carta3 = carta1
  | maiorCarta carta1 carta2 carta3 == carta3 && menorCarta carta1 carta2 carta3 == carta1 = carta2
  | maiorCarta carta1 carta2 carta3 == carta3 && menorCarta carta1 carta2 carta3 == carta2 = carta1

verificaSeONaipeÉIgual:: Carta -> Carta -> Carta -> Bool
verificaSeONaipeÉIgual carta1 carta2 carta3 =
  naipe (maiorCarta carta1 carta2 carta3) == naipe (cartaMediana carta1 carta2 carta3)
  && naipe (cartaMediana carta1 carta2 carta3) == naipe (menorCarta carta1 carta2 carta3)

verificaSeONaipeÉDiferente:: Carta -> Carta -> Carta -> Bool
verificaSeONaipeÉDiferente carta1 carta2 carta3 =
  naipe (maiorCarta carta1 carta2 carta3) /= naipe (cartaMediana carta1 carta2 carta3)
  && naipe (cartaMediana carta1 carta2 carta3) /= naipe (menorCarta carta1 carta2 carta3)
  && naipe (maiorCarta carta1 carta2 carta3) /= naipe (menorCarta carta1 carta2 carta3)

verificaSeOValorAcrescentadoÉIgual:: Carta -> Carta -> Carta -> Bool
verificaSeOValorAcrescentadoÉIgual carta1 carta2 carta3 =
  valor (maiorCarta carta1 carta2 carta3) == (valor (cartaMediana carta1 carta2 carta3)+1)
  && (valor (cartaMediana carta1 carta2 carta3)+1) == (valor (menorCarta carta1 carta2 carta3)+2)

verificaSeOValorÉIgual:: Carta -> Carta -> Carta -> Bool
verificaSeOValorÉIgual carta1 carta2 carta3 =
  valor (maiorCarta carta1 carta2 carta3) == valor (cartaMediana carta1 carta2 carta3)
  && valor (cartaMediana carta1 carta2 carta3) == valor (menorCarta carta1 carta2 carta3)

éJogo:: Carta -> Carta -> Carta -> Bool
éJogo carta1 carta2 carta3 =
  verificaSeONaipeÉIgual carta1 carta2 carta3 &&  verificaSeOValorAcrescentadoÉIgual carta1 carta2 carta3
  || verificaSeONaipeÉDiferente carta1 carta2 carta3 && verificaSeOValorÉIgual carta1 carta2 carta3



{--

>>>verificaSeONaipeÉIgual (1,"ouro") (1,"paus") (1,"copas")
False

>>>verificaSeOValorAcrescentadoÉIgual (1,"ouro") (1,"paus") (1,"copas")
False

>>>verificaSeONaipeÉDiferente (1,"ouro") (1,"paus") (1,"copas")
True

>>>verificaSeONaipeÉIgual (1,"ouro") (1,"paus") (1,"copas")
False

>>>cartaMediana (1,"paus") (1,"ouro") (1,"copas") 
(1,"ouro")

>>>cartaÉMenor (1,"copas") (1,"ouro") 
True


>>>somaTresNumeros 1 2 5
8

>>>maiorDeTres 1 2 5
5

>>>eLógico True True
True

>>>subStringDeAte ("entrada1"::String) (2::Int) (2::Int)
"tr"

>>>ultimosU "entrada1" 2
"a1"

>>>pedraTesouraPapel "papel" "pape"
"opcao invalida"

>>>subStringDeAteAppend ("entrada1"::String) ("entrada2"::String) 2 2
"trtr"

>>>naipe (3, "ouro")
"ouro"

>>>valor (3, "ouro")
3

>>>cartaÉMenor (1, "ouro") (1, "ouro")
False

>>>cartaÉMenor (1, "copas") (1, "ouro")
True

>>>cartaÉMenor (1, "ouro") (2, "ouro")
True

>>>cartaÉIgual (1, "ouro") (1, "ouro")
True

>>>cartaÉIgual (1, "copas") (1, "ouro")
False

>>>cartaÉIgual (1, "ouro") (2, "ouro")
False

>>>cartaÉMaior (1, "ouro") (1, "ouro")
False

>>>cartaÉMaior (1, "copas") (1, "ouro")
False

>>>cartaÉMaior (1, "ouro") (2, "ouro")
False

>>>cartaÉMaior (3, "ouro") (2, "ouro")
True

>>>maiorCarta (3, "ouro") (2, "ouro") (4, "ouro")
(4,"ouro")

>>>menorCarta (3, "ouro") (1, "ouro") (4, "ouro")
(1,"ouro")
>>>cartaMediana (2, "ouro") (3, "ouro") (4, "ouro") 
(3,"ouro")

>>>verificaSeONaipeÉIgual (2, "paus") (3, "ouro") (4, "ouro") 
False

>>>verificaSeOValorÉIgual (1,"ouro") (2,"ouro") (3,"ouro") 
False

>>>verificaSeOValorÉIgual (1,"ouro") (1,"ouro") (1,"copas")
/home/matheus/Github/personal/academy/functional/try-2021-01/aula-28-07-2021/aula.hs:(70,1)-(76,99): Non-exhaustive patterns in function cartaMediana

>>>verificaSeONaipeÉDiferente (2, "paus") (3, "ouro") (4, "paus") 
False

>>>éJogo (1,"ouro") (2,"ouro") (3,"ouro")
True
>>>éJogo (1,"ouro") (1,"ouro") (1,"copas")
/home/matheus/Github/personal/academy/functional/try-2021-01/aula-28-07-2021/aula.hs:(70,1)-(76,99): Non-exhaustive patterns in function cartaMediana

>>>éJogo (1,"ouro") (1,"paus") (1,"copas")
True

--}
