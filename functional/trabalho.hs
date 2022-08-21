--Nome: Andressa Oliveira Bernardes
--Matrícula: 12121BSI201


--referencia: https://stackoverflow.com/questions/30221792/write-at-the-beginning-of-a-file-in-haskell

module Main (main) where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))

--criando os arquivos
main = do writeFile "saldo.txt" "0"
          writeFile "extrato.txt" "0"
          menu

menu = do putStrLn "==================================="
          putStrLn "Banco Andressa Oliveira Bernardes"
          putStrLn "==================================="
          putStrLn "Opções: "
          putStrLn "1. Saldo"
          putStrLn "2. Extrato"
          putStrLn "3. Depósito"
          putStrLn "4. Saque"
          putStrLn "5. Fim"
          putStrLn "Escolha uma opção: "
          opcao <- readLn
          case opcao of
                5 -> putStrLn "Obrigada por usar o banco!"
                1 -> imprime "saldo.txt"
                2 -> imprime "extrato.txt"
                3 -> depositar
                4 -> sacar
                _ -> putStrLn "Opção inválida."
          if not (opcao == 5) then menu else putStrLn "Saindo..."

imprime :: String -> IO()
imprime arquivo = do 
      conteudo <- readFile arquivo
      putStrLn conteudo

depositar:: IO()
depositar = do
      putStrLn "Valor a depositar: "
      valor <- getLine
      deposito (read valor) 

sacar:: IO()
sacar = do
      putStrLn "Valor a sacar: "
      valor <- getLine
      saque (read valor) 

deposito :: Float -> IO()
deposito valor = do 
                  saldo <- readFile "saldo.txt"

                  let valorAtualizado = (read saldo) + valor
                  
                  putStrLn (show valorAtualizado)

                  writeFile "saldo.txt" (show valorAtualizado)  

                  appendFile "extrato.txt" ("\n+" ++ show valorAtualizado)

saque :: Float -> IO()
saque valor = do 
                  saldo <- readFile "saldo.txt"

                  let valorAtualizado = (read saldo) - valor
                  
                  putStrLn (show valorAtualizado)

                  writeFile "saldo.txt" (show valorAtualizado)  

                  appendFile "extrato.txt" ("\n-" ++ show valor)  
                    
imprimeNVezes:: Int -> IO()
imprimeNVezes 1 = putStrLn "Frase"
imprimeNVezes _ = putStrLn "Erro"
imprimeNVezes n = do
      putStrLn "Frase"
      imprimeNVezes (n-1)

imprimeNVezesString:: Int -> String
imprimeNVezesString 0 = ""
imprimeNVezesString n = "Frase"++show('\n')++imprimeNVezesString (n-1)




