--Exercício 01
quadradoDireita :: Num a => a -> a -> a
quadradoDireita n1 n2 = n1*n1 + n2

quadradoEsquerda :: Num a => a -> a -> a
quadradoEsquerda n1 n2 = n1 + n2*n2

somaQuadsR :: (Num b, Enum b) => b -> b
somaQuadsR numero = foldr quadradoDireita 0 [1..numero]

somaQuadsL :: (Num b, Enum b) => b -> b
somaQuadsL numero = foldl quadradoEsquerda 0 [1..numero]

--Exercício 02
operadorComprimentoDireita _ b = 1 + b

operadorComprimentoEsquerda a _ = a + 1

operadorDivisaoDireita n1 n2 = n1 `div` n1+n2

compR:: (Foldable t, Num b) => t p -> b
compR lista = foldr operadorComprimentoDireita 0 lista

compL :: (Foldable t, Num b) => t p -> b
compL lista = foldl operadorComprimentoEsquerda 0 lista

--Exercício 03

mínimoR :: (Foldable t, Ord a) => t a -> a
mínimoR lista = foldr1 min lista --foldr1 usa como elemento neutro o último elemento da lista

mínimoL :: (Foldable t, Ord a) => t a -> a
mínimoL lista = foldl1 min lista --foldl1 usa como elemento neutro o primeiro elemento da lista

--Exercício 04

operadorDireita :: a -> [a] -> [a]
operadorDireita a b = b ++ [a]

reverteR :: Foldable t => t a -> [a]
reverteR lista = foldr operadorDireita [] lista

reverteL :: Foldable t => t a -> [a]
reverteL lista = foldl (flip (:)) [] lista

--Exercício 05

removeDupR :: (Foldable t1, Foldable t2, Eq a) => t2 a -> t1 a -> [a]
removeDupR lista1 lista2 = foldr operador [] lista2
    where operador elemento lista = if elemento `elem` lista1 then lista else elemento:lista
    -- removeDupR [1,2] [0,1,2,3] --> 0 `op` (1 `op` (2 `op` (3 `op` i)))
                                                                              -- []
                                                                        -- [3]
                                                                -- [3]
                                                        -- [3]
                                                --[0,3]

removeDupL :: (Foldable t1, Foldable t2, Eq a) => t2 a -> t1 a -> [a]
removeDupL lista1 lista2 = foldl operador [] lista2
    where operador lista elemento = if elemento `elem` lista1 then lista else lista ++ [elemento]
        -- removeDupL [1,2] [0,1,2,3] --> [] ++ [0] ++ [1] ++ [2] ++ [3] -> [1,2,3]
        -- removeDupL [1,2] [0,1,2,3] --> 0 `op` (1 `op` (2 `op` (3 `op` i)))
                                                    -- []++0
                                                               --[0]
                                                                       --[0]
                                                                               --[0]++3
                                                                                         --[0,3]

--Exercício 06



--foldr min [1..10]