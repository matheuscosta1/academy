import Prelude hiding (even,odd,abs,not,(&&),(||), map, zip, show)
import Data.Char



double x = x+x
quadruple x = double (double x)
factorial n = product [1..n]
average ns = sum ns `div` length ns

n = a `div` length xs --e a identação deve estar correta, senão dará erro. Div é de divisão!
    where
    a = 10
    xs = [1,2,3,4,5]
    
-- e // dobro :: Int -> Int // --e Tipo de dado da função dobro e o o Tipo de dado que ela vai me fornecer como resultado 

--dobro :: Int -> Int
--dobro x =  2*x

-- e fat n = n * fat(n-1)

-- e comb n p = fat n / (fat p) * (fat(n-p))

pegar xs = drop (length xs - 1) xs --e tirei os n primeiro elementos de uma lista --> drop (elementos) [...]

--e :type serve para descobrir o tipo do dado que estou querendo
--e :t não faz calculo, apenas devolve o valor associado à expressão

--e Haskell é uma linguagem fortemente "typada". É uma vantagem da linguagem, para o programador detectar erros mais facilmente.

--e Suponhamos a expressão 2*(5-8) <= 9*1. :t 2*(5-8) <= 9*1; retornará um Bool --> like this 2*(5-8) <= 9*1 :: Bool

--e (5.6,("Ana",18),’F’) ::(Double,(String,Int),Char)

add :: (Int,Int)->(Int)
add(x,y) = x+y

--zeroto :: Int -> [Int]
--zeroto n = [0,2..n]  --e (..) é para simplificar a representação de uma lista. 

zeroto :: Int -> [Int]
zeroto n = [-n..n]  --e (..) é para simplificar a representação de uma lista. 

-- even n = mod n 2==0 --e retorna True ou falso; 5%2==0? Sim, True; Não, False
-- odd n = not (even n) --e retorna True se o módulo do numero por 2 nao for igual a 0; False se for.

-- even n = n ‘mod‘ 2 == 0
-- length( if 2<=1 then "OK" else "FAIL") //  retornará o tamanho da String FAIL, no caso, 4. 

-- A cláusula else não é opcional em uma expressão condicional. Omiti-la é um erro de sintaxe.
-- A expressão que vem depois do if e a expressão que vem depois do else tem que ser de um mesmo tipo de dado.

abs n  |n>=0 = n
      |otherwise = -n
       
--a (x) = case x of
--  0 -> "zero"
--  1 -> "um"
--  2 -> "dois"
--  3 -> "tres"
  
  
a = case (3+2,5-2) of
 (0,0) -> 10
 (_,1) -> 20
 (x,2) -> x^2
 (x,y) -> x*y-1
  
--b = case 46-2*20 of
--  0 -> "zero"
--  1 -> "um"
--  2 -> "dois"
--  3 -> "tres"
--  4 -> "quatro"
--  _-> "maior que quatro"
  
not :: Bool -> Bool
not False = True
not True = False

(&&) :: Bool -> Bool -> Bool

True && True = True
True && False = False
False && True = False
False && False = False 

even n = n `mod` 2 == 0 --e retorna True ou falso; 5%2==0? Sim, True; Não, False //Even: boolean normal
odd n = not (even n) --e retorna True se o módulo do numero por 2 nao for igual a 0; False se for. //odd boolean inverso

f(x,y) = (a+1)*(a+2) 
    where a = (x+y)/2

g(x,y) = (a+1)*(b+2)
    where 
    a = (x+y)/2
    b = (x+y)/3
    
h y = 3 + f y + f a + f b
    where
    c=10
    (a,b) =(3*c,f 2)
    f x = x+7*c

k a = let { y=1+2; z=4+6} in y+z

-- com let as definicoes sao colocadas no inicio, já com where, no final. Todavia, where não é uma expressão, podendo ser utilizada apenas para fazer definicoes locais.
calculoRaizes :: Float -> Float -> Float -> (Float, Float)
calculoRaizes a b c = let 
                          delta = (b*b) - (4*a*c)
                          x1 = ((-b + sqrt(delta))/(2*a))
                          x2 = ((-b - sqrt(delta))/(2*a))
                      in  
                          if delta >= 0 then (x1,x2) else error "Não existem raizes reais"
                          
eh_Digito1 :: Char -> Bool
eh_Digito1 x = (x >= '0') && (x <= '9') 
                 
eh_Digito :: Char -> Bool
eh_Digito x = isDigit x

triplo x = 3*x

maiorDe3 a b c = if (a>b) && (a>c) then a else if (b>a) && (b>c) then b else c

somatorio :: Int -> Int
somatorio 1 = 1
somatorio n = n+somatorio(n-1)

nEsimoTermoPA :: Int -> Int -> Int -> Int
nEsimoTermoPA a1 1 r = a1
nEsimoTermoPA a1 n r = r + nEsimoTermoPA a1 (n-1) r

soma :: [Int] -> Int
soma [] = 0
soma (x:xs) = x + (soma xs)

dobraLista :: [Int] -> [Int]
dobraLista xs = [2*x | x<-xs, x>0]

--paresOrd :: (x,y) -> [(x,y)] 
--paresOrd (x,y) = [(x,y) | y <- [4,5], x <- [1,2,3]]

metade :: [a] -> ([a],[a])
metade lista = ( take k lista, drop k lista )
  where
   k = div (length lista) 2


misterio1 :: String -> String
misterio1 p = [c | c<-p, (c>='a') && (c<='z')]

retornaSup :: Int -> [Int] -> [Int]
retornaSup a [] = []
retornaSup a (x:xs) 
  | (x > a) = x:(retornaSup a xs)
  | otherwise = retornaSup a xs

zip :: [a] -> [b] -> [(a,b)]
zip [] ys = []
zip (x:xs) [] = []
zip (x:xs) (y:ys) = (x,y) : zip xs ys
  
dobraPos :: [Int] -> [Int]
dobraPos [] = []
dobraPos (x:xs) = if x>0 then 2*x: dobraPos xs else dobraPos xs -- se o x for positivo, entao dobra a posicao, senao; nao faz nada.  

dobra :: [Int] -> [Int]
dobra[] = []
dobra(x:xs) = ((2*x) : dobra xs)

dobraNeg :: [Int] -> [Int]
dobraNeg [] = []
dobraNeg (x:xs) = if x<0 then 2*x: dobraNeg xs else dobraNeg xs

pertenceList :: Eq t => t -> [t] -> Bool
pertenceList a [] = False
pertenceList f (x:xs) = if (f == x) then True else pertenceList f xs  

conta :: [a] -> Int --fazer uma recursao de cauda /// [a] polimorfismo; qualquer letra minúscula. Para representar um tipo generico
conta[] = 0
conta(x:xs) = 1 + conta xs

soma1 :: [Int] -> Int -> Int
soma1[] s = s
soma1(x:xs) s = soma1 xs(x+s)

primeiros :: Int -> [t] -> [t]
primeiros 0 _ = []
primeiros _ [] = []
primeiros n (x:xs) = x: primeiros (n-1) xs     

maior :: [Int] -> Int -- nao consigo passar tipo generico de dado [t] porque a funcao está comparando....
maior [x] = x
maior(x:y:resto) | x > y = maior(x: resto) -- | é uma condicional
                 | otherwise = maior(y:resto)
                 
uniaoListas :: Eq t => [t] -> [t] -> [t]
uniaoListas [] a = a
uniaoListas(x:xs) a = if pertenceList x a then uniaoListas xs a
                                          else x : uniaoListas xs a

dobro :: Int -> Int
dobro x = 2*x

aplicaTodos :: (Int -> Int) -> [Int] -> [Int]
aplicaTodos f [] = []
aplicaTodos f (x:xs) = ((f x) : aplicaTodos f xs)       

--map// funcao de ordem superior. Ajuda a deixar o codigo mais compacto, levando-nos a trabalhar com diversos tipos                

fatorial :: Int -> Int
fatorial 0 = 1
fatorial x =  fatorial((abs x)-1)*(abs x)

fatorialCauda :: Int -> Int -> Int
fatorialCauda 0 s = s
fatorialCauda x s = fatorialCauda (x-1) (x*s)

maiorf a b c  = if (a>b) && (a>c) then a else if (b>a) && (b>c) then b else c

maior2 a b =  if (a>b) then a else b

maiori :: Int -> Int -> Int -> Int
maiori a b c = if (c > maior2 a b) then c else maior2 a b

misterio :: Int -> Int -> Int -> Bool
misterio m n p = (not ((m==n)  && (n==p))) -- A função está falando que é verdade que é falso

b = case toUpper (head "masculino") of
  'F' -> 20.0
  'M' -> 10.0

c = case (head "Masculino" == 'F') of 
  True  -> "mulher"
  False -> "homem"
  
(||) :: Bool -> Bool -> Bool  

True  || True = True
True  || False = True
False || True = True
False || False = False

nEsimoTermoPG ::  Int -> Int -> Int -> Int
nEsimoTermoPG a1 1 q = a1
nEsimoTermoPG a1 n q =  q * nEsimoTermoPG a1 (n-1) q    

somaNPA ::  Int -> Int -> Int -> Int 
somaNPA a1 1 r = a1
somaNPA a1 n r = (nEsimoTermoPA a1 n r) + somaNPA a1 (n-1) r

somaNPG :: Int -> Int -> Int -> Int
somaNPG a1 1 q = 1
somaNPG a1 n q = (nEsimoTermoPG a1 n q) + somaNPG a1 (n-1) q

elimina_negativos l = filter negativos l
negativos :: Int -> Bool
negativos x = not(x<0)

retiraNegativos :: [Int] -> [Int]
retiraNegativos [] = []
retiraNegativos (x:xs) 
   | x < 0 = retiraNegativos xs  
   | otherwise = (x:(retiraNegativos xs))

elimiNeg xs = [x| x <- xs, x>=0] -- versão em compressão
   
retiraPares :: [Int] -> [Int]
retiraPares [] = []
retiraPares (x:xs)
    | (mod x 2 == 0) = retiraPares xs
    | otherwise = (x:(retiraPares xs)) 
    
elimPares xs = [x| x <- xs, not(mod x 2 == 0)] -- versão em compressão

incrementa :: Num a => [a] -> [a]
incrementa [] = []
incrementa (x:xs) = (x+1) : incrementa xs

incrementar :: Num a => [a] -> [a]
incrementar xs = [x+1 | x <- xs] 

convStrMaius :: [Char] -> [Char] 
convStrMaius xs = map (toUpper) xs

map :: (a -> b) -> [a] -> [b]
map f [] = []
map f (x:xs) = f x : map f xs

--Definir uma função que devolve o n-ésimo
--termo de uma seqüência de Fibonacci cujos 
--dois primeiros termos sejam 1 e 1.

fibo :: Int->Int
fibo n
  | (n == 1) || (n==2) = 1
  | otherwise = fibo (n-1) + fibo (n-2)


bissexto :: Int -> Bool
bissexto n
  | (mod n 400 == 0) = True
  | (mod n 4 == 0) && (mod n 100 /= 0) = True
  | otherwise = False

temDivisor :: Int -> [Int] -> Bool
temDivisor n [] = False
temDivisor n (x:xs) 
  | (mod n x) == 0 = True
  | otherwise = temDivisor n xs

--primo n = not (temDivisor n [2..(n-1)]) --começo no 2 porque todo numero divide por 1, daí dá sempre falso caso fique ele (terá divisor de cara)


divisores1 :: Int -> [Int]
divisores1 n = [x | x <- [1..n], mod n x == 0]

primo :: Int -> Bool
primo n = (divisores1 n == [1,n])

primos :: Int -> [Int]
primos n = [x | x <- [2..n], primo x]

caracMaius :: Char -> Bool 
caracMaius a = if a /= toUpper a then False else True 
 
repeteNCadeia :: Int -> String -> String
repeteNCadeia 1 a = a
repeteNCadeia n a = a++repeteNCadeia (n-1) a  

cadeiaBranco :: Int -> String
cadeiaBranco 1 = " "
cadeiaBranco n = " "++cadeiaBranco (n-1)

intervalo :: Int -> Int -> [Int]
intervalo a b
  |(a == b) = [a]
  |(a > b) = []
  |otherwise = intervalo a (b-1)++[b] 
  
duplicarElem :: [Int] -> [Int]
duplicarElem [] = []
duplicarElem (x:xs) = [x]++x : duplicarElem xs

--Construir uma função que, dado um valor inteiro, devolva a lista de todos os divisores deste número.

divisoresDesdeN :: Int -> Int -> [Int]
divisoresDesdeN n m 
  | (n == m) = [n]
  | (n > m) && (n`mod`m==0) = m:(divisoresDesdeN n (m+1))
  | (n > m) && (n`mod`m/=0) = divisoresDesdeN n (m+1)

divisoresNum :: Int -> [Int]
divisoresNum n = divisoresDesdeN n 1

divisores :: Int -> [Int]
divisores n = [x | x <- [1..n], n `mod` x ==0]

--Construir uma função que ordene uma lista de valores numéricos dados, em ordem crescente.

ordenaCrescente :: [Int] -> Int -> [Int]
ordenaCrescente [] n = [] -- n é a quantidade de elementos da lista
ordenaCrescente lista 0 = lista 
ordenaCrescente lista n = ordenaCrescente (trocaPosC (lista)) (n-1) 

trocaPosC :: [Int] -> [Int]
trocaPosC [y] = [y]
trocaPosC (x:y:xs) 
  | x < y = x:trocaPosC(y:xs)
  | otherwise = y:trocaPosC (x:xs)
 
ordenaDecrescente :: [Int] -> Int -> [Int]
ordenaDecrescente [] n = [] -- n é a quantidade de elementos da lista
ordenaDecrescente lista 0 = lista 
ordenaDecrescente lista n = ordenaDecrescente (trocaPosD (lista)) (n-1) 
 
trocaPosD :: [Int] -> [Int]
trocaPosD [y] = [y]
trocaPosD (x:y:xs) 
  | x < y = y:trocaPosD(x:xs)
  | otherwise = x:trocaPosD(y:xs)  
  
--Construir uma função que receba uma lista de inteiros e os separe em duas listas: a primeira 
--contendo os pares e a segunda contendo os ímpares. Devolver o resultado como uma lista de listas

divideListaPI :: [Int] -> ([Int],[Int])  --divide uma lista em uma lista de pares e outra de ímpares
divideListaPI [] = ([],[])
divideListaPI (x:xs)
  | (x `mod` 2 == 0) = (x:pares, impares)
  | otherwise = (pares, x:impares)
  where (pares, impares) = divideListaPI xs

--Construir uma função que dadas duas listas numéricas ordenadas devolva uma lista união (com 
--repetição) das listas dadas  

uniaoListasOrden :: [Int] -> [Int] -> [Int]
uniaoListasOrden [][] = []
uniaoListasOrden lista1 lista2 = lista1 ++ lista2

--Construir uma função que receba uma lista de objetos e um valor inteiro n e devolva todas as 
--combinações destes objetos, com repetição, de tamanho n

combinar :: [Int] -> Int -> [Int]
combinar [] n = []
combinar (x:xs) n
  |n>=0 = x:[n]++combinar xs n

combinar2 [] _ = []
combinar2 (x: xs) n = x : (n : combinar xs n)
--combinar (x:xs) n = ((x:combinar xs n)++[n])
 
parImpar :: [Int]->[[Int]]
parImpar [] = [[],[]]
parImpar (x :xs) | mod x 2 ==0 = [x: head (parImpar xs), last (parImpar xs)]
parImpar (x : xs) = [head (parImpar xs), x : last (parImpar xs)]

-- Trabalhando com compreensão 
--combinaPares :: Num x => Int -> [(x,y)]
--combinaPares x = [(x,y) | x <- [1,2,3], y <- [4,5]]

concat1 :: [[a]] -> [a]
concat1 listaComListas = [x|lista <- listaComListas, x <- lista]

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = quicksort menores ++ [x] ++ maiores 
  where
    menores = [a| a <- xs, a <= x]
    maiores = [b| b <- xs, b > x]

mergesort :: (Ord a) => [a] -> [a] -> [a]
mergesort [] y = y
mergesort x [] = x
mergesort (x:xs) (y:ys) 
  | x <= y = x:mergesort xs (y:ys) 
  | otherwise = y: mergesort (x:xs) ys

-- Trabalhando conceito de recursividade -- aula 02/05

pot2 :: Int -> Int
pot2 x 
  | (x == 0) = 1
  | (x > 0) = 2*pot2 (x-1)
  | otherwise =  2*pot2 ((abs x)-1)
  
multiplicacao :: Int -> Int -> Int
multiplicacao m n 
  | (n == 0) = 0
  | (n > 0) = m + multiplicacao m (n-1)
  | otherwise = -(multiplicacao m (-n))

data Complexos = Complexos (Int, Int)
--  deriving (Eq, Show)

<<<<<<< HEAD
instance Show Complexos
  where 
    show(Complexos(x,xi)) = if(xi>0) then (show xi)++"+"++(show xi) else (show x)++" "
  
instance Num Complexos
  where
  (+) = add1
  (-) = sub1  

add1 :: Complexos -> Complexos -> Complexos
add1 (Complexos(a,b)) (Complexos(c,d)) = (Complexos(a+c, b+d))

sub1 :: Complexos -> Complexos -> Complexos
sub1 (Complexos(a,b)) (Complexos(c,d)) = Complexos(a+c, b+d)
=======
--instance Show Complexos
--  where 
--    show(Complexos(x,xi)) = if(xi>0) then (show xi)++"+"++(show xi) else (show x)++" "
  
--instance Num Complexos
--  where
--  (+) = add1
--  (-) = sub1  

--add1 :: Complexos -> Complexos -> Complexos
--add1 (Complexos(a,b)) (Complexos(c,d)) = (Complexos(a+c, b+d))
--
--sub1 :: Complexos -> Complexos -> Complexos
--sub1 (Complexos(a,b)) (Complexos(c,d)) = Complexos(a+c, b+d)
