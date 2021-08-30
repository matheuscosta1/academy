module Root.Src.Exercise where

implementar = error "Implementar"

{- 
Nos seguintes exercícios, use listas para resolver os problemas propostos.
Em vários lugares, facilita se usar where/let-in, por exemplo se for usar a cabeca da lista múltiplas vezes

funcao l = ????
   where cabeca = head l
         cauda = tail l 
-}


{-
Um palíndromo é uma palavra que pode ser lida da esquerda para a direita ou da direita para a esquerda com o mesmo resultado, como por exemplo, ovo e Natan.
O conceito pode ser estendido para frases se ignorarmos espaços, acentos e sinais de pontuação, por exemplo, "Olé! Maracujá, caju, caramelo." mas, por enquanto, estamos interessados apenas palavras palíndromas.

Escreva uma função que teste se a entrada é uma palavra (não contém espaços).
Assuma que a entrada não tem acentos ou pontuações e que ou todas as letras são maiúsculas ou todas são minúsculas.

Entrada:
    - s - String

Resultado: 
    - True se s é uma palavra palíndroma; False caso contrário.

Exemplos:
>>>palíndromo "ana"
True
>>>palíndromo "jose"
False

>>>palíndromo "natan foi viajar"
False

>>>palíndromo "natan"
True
-}

palíndromo :: String -> Bool
palíndromo string = string == reverse string

{-
Na próxima semana, escreva uma função que teste se uma frase é palíndroma.
-}


{-
O conceito de palíndromo pode ser aplicado a qualquer lista, por exemplo de inteiros. Neste caso, [1,2,3,4,5,4,3,2,1] seria um palíndromo.
Escreva uma função que teste se uma lista qualquer é um palíndromo.
O tipo da função está definido para você e diz que a lista pode ser de qualquer tipo que se possa comparar com um ==

Entrada:
    - s - lista de inteiros

Resultado: 
    - True se s é uma lista palíndroma; False caso contrário.

Exemplos:
>>>palindrome "ana"
True
>>>palindrome "jose"
False

>>>palindrome [1,2,3]
False

>>>palindrome [True,False,False,True]
True

-}

convertStringIntoList :: String -> [String]
convertStringIntoList "" = []
convertStringIntoList string = take 1 string : convertStringIntoList (drop 1 string)


palindrome :: Eq a => [a] -> Bool
palindrome lista = reverse lista == lista


{-
Frequentemente precisamos limpar dados entrados por usuários em fomulários.
Por exemplo, precisamos tirar os espaços no início e fim dos dados digitados, como em " José de Abreu  "
Algumas linguagens tem uma função trim que remove tais espaços em branco.

Implemente uma função que elimine todos os espaços em branco no início e fim de uma string.

>>>trim "Implemente uma"
"Implemente uma"

>>>trim " Implemente uma "
"Implemente uma"

>>>trim "  Implemente uma  "
"Implemente uma"

>>>trim "   Implemente uma"
"Implemente uma"

>>>trim "Implemente uma   "
"Implemente uma"
-}


convertListIntoString:: [String] -> String
convertListIntoString = concat


trim:: String -> String
trim string = convertListIntoString (reverse (dropWhile (== " ") (reverse (dropWhile (== " ") (convertStringIntoList string)))))


{-
Eu não tenho uma historia bonitinha para esta função, então vamos direto ao ponto.
Escreva uma função que quebre uma String em todo lugar em que aparecer um certo caractere.

Entrada:
    - l - String a ser dividida
    - d - delimitador

Saída:
    - Lista de strings resultante da divisão.

>>>splitTodos "Por exemplo, precisamos tirar os espaços no início e fim dos dados digitados, como em José de Abreu " ' '
["Por","exemplo,","precisamos","tirar","os","espa\231os","no","in\237cio","e","fim","dos","dados","digitados,","como","em","Jos\233","de","Abreu",""]

>>>splitTodos "Por exemplo, precisamos tirar os espaços no início e fim dos dados digitados, como em José de Abreu " 'i'
["Por exemplo, prec","samos t","rar os espa\231os no ","n\237c","o e f","m dos dados d","g","tados, como em Jos\233 de Abreu "]

>>>splitTodos "Por exemplo, precisamos tirar os espaços no início e fim dos dados digitados, como em José de Abreu " 'a'
["Por exemplo, precis","mos tir","r os esp","\231os no in\237cio e fim dos d","dos digit","dos, como em Jos\233 de Abreu "]
-}
splitTodos :: [Char] -> Char -> [[Char]]
splitTodos "" a = []
splitTodos lista caractere = takeWhile (/= caractere) lista : splitTodos (drop 1 (dropWhile (/= caractere) lista)) caractere




{-
Escreva uma função que retorne duplas formadas pelos por elementos das duas metades da lista, sendo o primeiro elemento do resultado formado pelo 
primeiro elemento da primeira metade da lista mais o primeiro da segunda metade da lista, o segundo elemento formado pelo segundo elemento da primeira
metade mais o segundo elemento da segunda metade e assim por diante.

>>>combinaMetades [1,2,3,4,5,6]
[(1,4),(2,5),(3,6)]

>>>combinaMetades [1,2,3,4,5,6,7]
[(1,4),(2,5),(3,6)]

-}

primeiraMetadeLista :: [Int] -> [Int]
primeiraMetadeLista lista = takeWhile (<=(length lista `div` 2)) lista

segundaMetadeLista :: [Int] -> [Int]
segundaMetadeLista lista = dropWhile (<=(length lista `div` 2)) lista

combinaMetades :: [Int] -> [(Int,Int)]
combinaMetades lista = zip (primeiraMetadeLista lista) (segundaMetadeLista lista)


{-
Escreva uma função que reverta combinaMetades. Ou seja
>>>descombinaMetades [(1,4),(2,5),(3,6)] 
[1,2,3,4,5,6]
-}
descombinaMetades :: [(Int, Int)] -> [Int]
descombinaMetades lista = map fst lista ++ map snd lista


{-
Escreva uma função separe repetições consecutivas dentro de uma lista.

>>>empacote "aaaabccaadeeee"
["aaaa","b","cc","aa","d","eeee"]

>>>empacote ""
[]


>>>empacote [1,1,12,2,2,3,3,3,4,4,4,3,3,3,2,2,2,1,1,1]
[[1,1],[12],[2,2],[3,3,3],[4,4,4],[3,3,3],[2,2,2],[1,1,1]]

-}

empacote :: (Eq a) => [a] -> [[a]]
empacote [] = []
empacote lista = takeWhile (==head lista) lista : empacote (dropWhile (==head lista) lista)

{-
Dado uma lista empacotada, como a gerada pela função anterior, gere uma lista de duplas tal que:
- para cada pacote haja uma dupla no resultado.
- a dupla tem como primeiro elemento o dado repetido na lista correspondente e como segundo elemento o comprimento de tal lista.

>>>compacte [[1,1],[12],[2,2],[3,3,3],[4,4,4],[3,3,3],[2,2,2],[1,1,1]]
[(1,2),(12,1),(2,2),(3,3),(4,3),(3,3),(2,3),(1,3)]

>>>compacte ["aaaa","b","cc","aa","d","eeee"]
[('a',4),('b',1),('c',2),('a',2),('d',1),('e',4)]

>>>compacte []
[]

>>>compacte [[1,1],[12],[2,2],[3,3,3],[4,4,4],[3,3,3]]
[(1,2),(12,1),(2,2),(3,3),(4,3),(3,3)]

-}
compacte :: [[a]] -> [(a, Int)]
compacte [] = []
compacte lista = (head (head lista), length (head lista)) : compacte (drop 1 lista)


{-
Escreva uma função que reverta a função compacte, definida acima, ou seja, tal que
>>>descompacte (compacte [[1,1],[12],[2,2],[3,3,3],[4,4,4],[3,3,3]]) == [[1,1],[12],[2,2],[3,3,3],[4,4,4],[3,3,3]]
True

-}

descompacte :: [(a, Int)] -> [[a]]
descompacte [] = []
descompacte (x:xs) = replicate (snd x) (fst x) : descompacte xs

{-
Escreva uma função que reverta a função empacote, acima, definida acima, ou seja, tal que
>>>desempacote (empacote "aaaabccaadeeee") == "aaaabccaadeeee"
True

-}

desempacote :: [[a]] -> [a]
desempacote [] = []
desempacote (x:xs) = x ++ desempacote xs
