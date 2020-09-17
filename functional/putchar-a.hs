module Main (main) where

--import System.IO (stdout, hFlush)
import System.IO(stdout, hSetBuffering, BufferMode(NoBuffering))

main :: IO()
main = do 
        hSetBuffering stdout NoBuffering
        putStrLn "Digite uma sequencia de numeros"
        putStrLn "Para terminar digite o valor zero" 
        lista <- lerLista []
		putStr "A soma dos numeros digitados é"
		putStrLn(show((sum lista)`div`length lista))


lerLista xs = do x <- readLn
                 if x==0
				   then return (reverse xs)
				   else lerLista (x:xs)
	  
{-main :: IO()
main = do hSetBuffering stdout NoBuffering
          putStr "Quantos numeros deseja somar?"
          n <- readLn
          s <- somatorio 0 n 0
          putStr (show s)
		  
somatorio :: Int -> Int -> Int -> IO Int
somatorio i n s 
  | i == n = return s
  | otherwise = do putStr "Digite um valor: " 
                   s <- readLn 
                   if i<n somatorio (i+1) n (s+1) then else
-}				   
	 
{-main :: IO ()

main = do hSetBuffering stdout NoBuffering
		  --putStrLn"Qual é o seu nome?"
          --nome <- getLine
          --putStr nome
          --putStrLn", seja bem vindo(a)!" 
          ------------------------------------
          {-hSetBuffering stdout NoBuffering
          putStrLn""
          putStr"Digite um número: "
          n1 <- getLine
          putStr"Digite outro número: "
          n2 <- getLine
          putStrLn""
          putStr"Soma dos numeros digitados: "
          putStrLn (show(read n1+ read n2))-}
-}
			 
          ------------------------------------
          --putStrLn"Digite um número:"
          --n1 <- readLn
          --putStrLn"Digite outro número:"
          --n2 <- readLn
          --putStr"Soma dos numeros digitados:"
          --putStrLn (show((n1::Float)+(n2::Float)))
          ------------------------------------
          --putChar 'A';
          --putChar 'i';
          --putChar 'm'
         -------------------------------------
          --putStrLn"Digite um número:"
          --n1 <- readLn
          --putStrLn"Digite outro número:"
          --n2 <- readLn
          --putStr"Multiplicacao dos numeros digitados:"
          --putStrLn (show((n1::Float)*(n2::Float)))   
          -------------------------------------
          --putStr"Digite um numero: "
          --hFlush stdout
          --s1 <- getLine
          --putStr"Digite outro numero: "
          --hFlush stdout
          --s2 <- getLine
          --putStr "Soma dos numeros digitados: "
          --putStrLn(show((read s1::Float) + (read s2::Float)))
          -------------------------------------
          
---primeiro eu entro na pasta do meu arq; pra executar essa joça no ruindows eu crio o meu arquivo; depois compilo pelo cmd utilizando ghc --make (nome arq)

--executo o meu arquivo chamando pelo nome