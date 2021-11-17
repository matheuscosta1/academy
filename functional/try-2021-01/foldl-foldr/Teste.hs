-- Tests for the Root.Src.Finder module.
--
-- All tests in the folder "Test" are executed 
-- when the "Test" action is invoked.

module Root.Test.FinderSpec where

import Root.Src.Finder
import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)

main = hspec spec

spec::Spec
spec = do
        describe "Testes da função funçãoExemploR" $ do -- Coloque o nome da função aqui
                it "NomeDoTeste1" $ do                 -- Coloque o nome do teste aqui
                        funçãoExemploR 1 3 `shouldBe` 4 -- Invoque a função do lado esquerdo e coloque a resposta esperada do lado direito.
                it "NomeDoTeste2" $ do                 -- Repita para o segundo teste
                        funçãoExemploR 0 0 `shouldBe` 0
        describe "Testes da funçãoExemploL" $ do              
                it "NomeDoTeste1" $ do
                        funçãoExemploL 1 3 `shouldBe` 4
                it "NomeDoTeste2" $ do
                        funçãoExemploL 0 0 `shouldBe` 0
        describe "Soma quadrados Direita" $ do             
                it "Soma quadrados direita 1" $ do
                        somaQuadsR 3 `shouldBe` 14
                it "Soma quadrados direita 2" $ do
                        somaQuadsR 4 `shouldBe` 30
        describe "Soma quadrados Esquerda" $ do              
                it "Soma quadrados esquerda 1" $ do
                        somaQuadsL 3 `shouldBe` 14
                it "Soma quadrados esquerda 2" $ do
                        somaQuadsL 4 `shouldBe` 30
        describe "Comprimento Direita" $ do              
                it "Comprimento direita 1" $ do
                        compR [1,2,3] `shouldBe` 3
                it "Comprimento direita 2" $ do
                        compR [] `shouldBe` 0
        describe "Comprimento Esquerda" $ do              
                it "Comprimento esquerda 1" $ do
                        compL [1,2,3] `shouldBe` 3
                it "Comprimento esquerda 2" $ do
                        compL [] `shouldBe` 0
        describe "Mínimo Direita" $ do             
                it "Mínimo direita 1" $ do
                        mínimoR [1,2,3] `shouldBe` 1
                it "Mínimo direita 2" $ do
                        mínimoR [10,8,5] `shouldBe` 5
        describe "Mínimo Esquerda" $ do             
                it "Mínimo esquerda 1" $ do
                        mínimoL [1,2,3] `shouldBe` 1
                it "Mínimo esquerda 2" $ do
                        mínimoL [10,8,5] `shouldBe` 5
        describe "Reverte Direita" $ do             
                it "Reverte direita 1" $ do
                        reverteR [1,2,3] `shouldBe` [3,2,1]
                it "Reverte direita 2" $ do
                        reverteR [10,8,5] `shouldBe` [5,8,10]
        describe "Reverte Esquerda" $ do             
                it "Reverte esquerda 1" $ do
                        reverteL [1,2,3] `shouldBe` [3,2,1]
                it "Reverte esquerda 2" $ do
                        reverteL [10,8,5] `shouldBe` [5,8,10]
        describe "Remove duplicados Direita" $ do             
                it "Remove duplicados direita 1" $ do
                        removeDupR [1,2,3] [0,1,2,4,3,5] `shouldBe` [0,4,5]
                it "Remove duplicados direita 2" $ do
                        removeDupR [2,5] [0,1,2,4,3,5] `shouldBe` [0,1,4,3]
        describe "Remove duplicados Esquerda" $ do             
                it "Remove duplicados esquerda 1" $ do
                        removeDupL [1,2,3] [0,1,2,4,3,5] `shouldBe` [0,4,5]
                it "Remove duplicados esquerda 2" $ do
                        removeDupL [2,5] [0,1,2,4,3,5] `shouldBe` [0,1,4,3]
        
