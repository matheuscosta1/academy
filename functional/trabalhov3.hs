--Nome: Andressa Oliveira Bernardes
--Matrícula: 12121BSI201

module Main (main) where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))

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
                5 -> do putStrLn "Obrigada por usar o banco!"
                1 -> do putStr "Valor do saldo: R$ "
                        imprime "saldo.txt"
                2 -> do putStrLn "Extrato bancário: "
                        imprime "extrato.txt"
                3 -> do putStr "Digite o valor que deseja depositar: R$ "
                        valorDep <- readLn
                        deposito valorDep
                4 -> do putStr "Digite o valor que deseja sacar: R$ "
                        valorSaq <- readLn
                        saque valorSaq
                _ -> do putStrLn "Opção inválida."
          if not (opcao == 5) then menu else putStrLn "Saindo..."

--criando os arquivos
main = do writeFile "saldo.txt" "0"
          writeFile "extrato.txt" "0"
          menu
          
--função imprime
imprime :: String -> IO()
imprime arquivo = do 
      conteudo <- readFile arquivo
      putStrLn conteudo
--função deposito
deposito :: Float -> IO()
deposito valor = do valorAntigo <- readFile "saldo.txt"
                    let valorAtualizado = (read valorAntigo) + valor
                    putStrLn (show valorAtualizado)
                    writeFile "saldo.txt" (show valorAtualizado)
                    appendFile "extrato.txt" ("\n+ " ++ (show valor))
                    -- show converte qualquer tipo em string
                    -- read converte string em qualquer tipo
--função saque
saque :: Float -> IO()
saque valor = do valorAntigo <- readFile "saldo.txt"
                 let valorAtualizado = (read valorAntigo) - valor
                 putStrLn (show valorAtualizado)
                 writeFile "saldo.txt" (show valorAtualizado)
                 appendFile "extrato.txt" ("\n- " ++ (show valor))