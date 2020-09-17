import Prelude hiding (even,odd,abs,not,(&&),(||), map, zip)
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
fatorial x =  fatorial(x-1)*x

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

--versao de cauda da funcao fibonacci 
fibonacci :: Int -> Int -> Int -> Int
fibonacci n a b
  | n == 0 = a
  | n == 1 = b
  | n >= 2 = fibonacci (n-1) b (a+b)
 
--versao de cauda da funcao potencia 
potencia2 :: Int -> Int -> Int
potencia2 n y
  | n==0 = y
  | n>0 = potencia2 (n-1) (2*y)

-------------- Trabalhando com expressões Lambda ----------------

triplo1 :: Num t => t -> t
triplo1 = \x -> x*3

soma3 :: Int -> (Int -> Int)
soma3 x = terminaSoma
  where terminaSoma y= x+y

soma4 :: Int -> (Int -> Int)
soma4 x = \y -> x+y  

soma5 :: Int -> (Int -> Int)
soma5 = \x -> (\y -> x+y)

soma6 :: Int -> Int -> (Int -> Int)
soma6 = \x -> \y -> (\z -> x+y+z) 

mult :: Int -> Int -> Int -> Int
mult = \x -> \y -> \z -> x*y*z

deriv :: Fractional a => (a -> a) -> a -> a -> a
deriv f dx = \x -> (f(x + dx) - f(x)) / dx


-------------- Trabalhando recursividade ----------------

-------------- Trabalhando com o Cálculo Lambda ----------------

-- Para fazer um Cálculo lambda via terminal (ghci), é necessário: 
-- Atentar ao uso de () nos sinais - e +
-- O pontinho (.) da expressão Lambda significa '\' em haskell
--Exemplos:
 -- (\x> \y> + x (\x> - x 3) y)) 5 6
 -- Expressões equivalentes:
							-- (\x -> (+) 1 x) 5
							-- (+ 1) 5
-- first (second (pair 1 (pair 2 3)))				
	-- tenho uma tupla (pair 1) e outra tupla (pair 2 3). Second irá me devolver a segunda tupla
	-- da segunda tupla terei um first, devolvendo o segundo argumento do pair: 2.

t = \x -> \y -> x
r = \x -> \y -> y

pair = \x -> \y -> \z -> z x y
first = \p -> p t
second = \p -> p r	
somaPar = \(x,y) -> x+y

funcTriplo :: Int -> Int
funcTriplo = \x -> 3*x

--posso definir uma funcao de ordem superior para utilizar essa minha função e, então, por exemplo, calcular o triplo de todos os valores de uma lista

type Aluno = (Int, String, Float) 
type Curso = [Aluno]

listaAlunos :: Curso
listaAlunos = [(1234, "Jose", 13.2),
               (2345, "Carlos", 9.7),               
               (3456, "Rosa", 17.9)]
			   
sucessor :: Int -> Int			   
sucessor = \x -> x+1

somaQuad :: [Int] -> Int
somaQuad [] = 0
somaQuad (x:xs)
  | x>0 = x*x + somaQuad xs
  | otherwise = somaQuad xs

duasVezes :: (a->a) -> a -> a
duasVezes f x = f (f x)

mapear :: (a -> b) -> [a] -> [b]
mapear f [] = []
mapear f (x:xs) = (f x) : mapear f (xs)

--intercala :: a -> [a] -> [[a]]
--intercala x [] = [[x]]
--intercala x (l:ls) [x:l:ls]++map(l:)(intercala x ls)
--------------------------------------

--1.
-- 8
-- 17
-- [2^3, 4^3, 6^8]
--
-- 3*16 = 48
-- 3*16 = 48
-- [9, 4, 4]
-- [(4,2), (6,3)]
-- [(4,1),(5,2), (6,3)]
-- [[(4,1),(6,2)], [(5,1), (7,2)]]
-- 6
--  {([(1+2+7) + 3 + 7] + 4 + 7) +5 +7} = 43

--2

data Nome = Nome String deriving (Show)
data Sobrenome = Sobrenome String deriving (Show)
instance Eq Nome 
    where
	 (==) = \x->(\y-> show x == show y)

instance Eq Sobrenome 
    where
	 (==) = \x->(\y-> show x == show y)

type NomeCompleto = (Nome,Sobrenome)

instance Ord Nome 
    where
	 (>=) = \x->(\y-> (length (show x)) >= (length (show y)))
	 (<=) = \y->(\x-> (length (show x)) >= (length (show y)))

instance Ord Sobrenome 
    where
	 (>=) = \x->(\y-> (length (show x)) >= (length (show y)))
	 (<=) = \y->(\x-> (length (show x)) >= (length (show y)))

compara ::  NomeCompleto->NomeCompleto->Bool
compara (x, y) (z, w) = (x == z) && (y == w)
----------------------------------------------------------------------------------
data NomeP = NomeP String deriving (Show)
data SobrenomeP = SobrenomeP String deriving (Show)

instance Eq NomeP where
  (==) x y = (show x == show y)
instance Eq SobrenomeP where
  (==) x y = (show x == show y)
instance Ord NomeP where
  (>=) x y = (length(show x)) >= (length(show y))   
  (<=) x y = (length(show x)) >= (length(show y)) 
instance Ord SobrenomeP where
  (>=) x y = (length(show x)) >= (length(show y))   
  (<=) x y = (length(show x)) >= (length(show y))
type NomeCompletoP = (NomeP, SobrenomeP)  
compara1 :: NomeCompletoP -> NomeCompletoP -> Bool
compara1 (x,w) (y,z) = (x == y) && (w==z) 
----------------------------------------------------------------------------------
--Classes 1.

data Complexo = Complexo (Integer, Integer) 

instance Show Complexo where
	show  = \(Complexo (x , xi))-> if xi > 0  then (show x) ++" + "++ (show xi)++"i"  else (show x) ++" "++ (show xi)++"i" 

instance Num Complexo
	where 
		(+) = \(Complexo (x,xi))->(\(Complexo (y, yi))-> Complexo (x + y, xi+yi))
		(-) = \(Complexo (x,xi))->(\(Complexo (y, yi))-> Complexo (x - y , xi-yi))

----------------------------------------------------------------------------------------------------------------		
data Complexo2 = Complexo2 (Integer, Integer)		

instance Show Complexo2 where
  show (Complexo2(x, xi)) = if xi > 0 then (show x)++" + "++(show xi)++"i" else (show x) ++" "++(show xi)++"i"
instance Num Complexo2 where
  (+) = add1 
  (-) = sub1   
  
add1 :: Complexo2->Complexo2->Complexo2
add1 (Complexo2(a, b)) (Complexo2 (c,d)) = Complexo2 (a+c, b+d)

sub1 :: Complexo2 -> Complexo2 -> Complexo2
sub1 (Complexo2(a,b)) (Complexo2(c,d)) = Complexo2(a-c, b-d)
-----------------------------------------------------------------------------------------------------------------
data Talvez a = Valor a | Nada deriving (Show)
divisaoSegura :: Float -> Float -> Talvez Float
divisaoSegura x y = if y == 0 then Nada else Valor (x/y)

const1 :: a -> b -> a
const1 x _ = x

impares n = map f[0..n] -- resulta numa lista de impares mapeada pela f de x.
  where
    f x = x*2+1
	
impares1 n = map (\x -> x*2+1) [0..n]

pares n = map f[0..n]	-- resulta numa lista de pares mapeada pela f de x.
  where
   f x = 2*x  
   
pares1 n = map (\x -> 2*x) [0..n]	
--quadrado :: [Int] -> [Int]
quadrado1 n = (map(\x->x^2)) [0..n]


type Pos = (Double, Double)
data Sentido = Esquerda | Direita | Acima | Abaixo deriving (Show)

move :: Sentido -> Pos -> Pos
move Esquerda (x,y) = (x-1, y)
move Direita  (x,y) = (x+1, y)
move Acima    (x,y) = (x, y+1)
move Abaixo   (x,y) = (x, y-1)

moves :: [Sentido] -> Pos -> Pos
moves [] p = p
moves (s:ss) p = moves ss (move s p)

data Cor = Azul | Amarelo | Verde | Vermelho

fria :: Cor -> Bool
fria Azul  = True
fria Verde = True
fria _     = False

quente :: Cor -> Bool
quente Amarelo  = True
quente Vermelho = True
quente _     = False

data Coord = Coord Double Double deriving (Show)

--coord :: Double -> Double -> Coord // esse sao os construtores do tipo Coord

somaVet :: Coord -> Coord -> Coord
somaVet (Coord x1 y1) (Coord x2 y2) = Coord (x1+x2) (y1+y2)

data Horario = AM Int Int Int | PM Int Int Int deriving (Show)

totalSegundos :: Horario -> Int
totalSegundos (AM h m s) = (h*60 + m)*60 + s
totalSegundos (PM h m s) = ((h+12)*60 +m)*60 + s

data Lista a = Nil | Cons a (Lista a) deriving (Show)

comprimento :: Lista a -> Int
comprimento Nil = 0
comprimento (Cons _ xs) = 1 + comprimento xs

data Cor1 = Azul1 | Verde1 | Amarelo1 | Vermelho1

instance Eq Cor1 where
 Azul1 == Azul1 = True
 Verde1 == Verde1 = True
 Amarelo1 == Amarelo1 = True
 Vermelho1 == Vermelho1 = True
 _ == _ = False
 
data BinTree a = V
                 | N a (BinTree a) (BinTree a)
instance (Eq a) => Eq (BinTree a) where
  V == V = True
  (N x1 l1 r1) == (N x2 l2 r2) = (x1 == x2) && (l1 == l2) && (r1 == r2)
  _            == _ = False


data Horario1 = AM1 Int Int Int | PM1 Int Int Int

instance Show Horario1 where
  show (AM1 h m s) = show h ++":"++show m++":"++show s++" am"
  show (PM1 h m s) = show h ++":"++show m++":"++show s++" pm"
 
mp f [] ys = []
mp f xs [] = []
mp f (x:xs) (y:ys) = f x y : mp f xs ys 

data Exp a = Val a -- um numero
 | Neg (Exp a)
 | Add (Exp a) (Exp a) -- soma de duas expressoes
 | Sub (Exp a) (Exp a) -- subtracao
 | Mul (Exp a) (Exp a) -- multiplicacao
 | Div (Exp a) (Exp a) -- divisao
avalia :: Fractional a => Exp a -> a
avalia (Val x) = x
avalia (Neg exp) = - (avalia exp)
avalia (Add exp1 exp2) = (avalia exp1) + (avalia exp2)
avalia (Sub exp1 exp2) = (avalia exp1) - (avalia exp2)
avalia (Mul exp1 exp2) = (avalia exp1) * (avalia exp2)
avalia (Div exp1 exp2) = (avalia exp1) / (avalia exp2)


------------------------------------------

data Par a b = Par(a,b) deriving (Eq)
data Lista'  a = Lista'[a] deriving (Eq)

instance (Ord a, Ord b)=> Ord( Par a b) where
 (<=) = \(Par (x1, x2)) ->(\(Par (y1, y2))-> if x1 <= y1 then True else if x2 <= y2 then True else False)
 
 
comparaListaMenor :: Ord a=>Lista' a-> Lista' a->Bool
comparaListaMenor  (Lista'[]) (Lista' _) = True
comparaListaMenor (Lista' _) (Lista' []) = False
comparaListaMenor (Lista' (a: xs)) (Lista' (b : ys)) | a > b = False
												   | otherwise = comparaListaMenor (Lista' xs) (Lista' ys)
  
instance (Ord a) => Ord(Lista' a) where
	(<=) = comparaListaMenor
	