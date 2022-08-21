--Nome: Andressa Oliveira Bernardes
--Matrícula: 12121BSI201


--referencia: https://stackoverflow.com/questions/30221792/write-at-the-beginning-of-a-file-in-haskell

module Main (main) where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering), IOMode(..), hClose, openFile, hPutStr, hGetLine)

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
                2 -> putStrLn "A operação escolhida ainda não foi implementada."
                3 -> putStrLn "A operação escolhida ainda não foi implementada."
                4 -> putStrLn "A operação escolhida ainda não foi implementada."
                _ -> putStrLn "Opção inválida."
          if not (opcao == 5) then menu else putStrLn "Saindo..."

--criando os arquivos

main = do 
      saldo <- openFile "saldo.txt" WriteMode
      hPutStr saldo "0"
      hClose saldo
      
      extrato <- openFile "extrato.txt" WriteMode
      hPutStr extrato "0"
      hClose extrato

      menu
      --writeFile "saldo.txt" "0"
      --writeFile "extrato.txt" "0"
      
--função imprime
imprime :: String -> IO()
imprime arquivo = do 
      conteudo <- readFile arquivo
      putStrLn conteudo
--função deposito


deposito :: Float -> IO()
deposito valor = do 
                  saldo <- openFile "saldo.txt" ReadMode

                  let valorAtual = hGetLine saldo

                  let valorAtualizado = read valorAtual + valor

                  hClose saldo

                  saldo <- openFile "saldo.txt" WriteMode

                  appendFile "saldo.txt" (show valorAtualizado)
                    