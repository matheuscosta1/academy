-- Tests for the Root.Src.Finder module.
--
-- All tests in the folder "Test" are executed 
-- when the "Test" action is invoked.

module Root.Test.FinderSpec where

import Root.Src.Finder
import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)
import Root.Src.Main (inverteFrase)

main = hspec spec

spec::Spec
spec = do
        describe "Testes da função funçãoExemploR" $ do -- Coloque o nome da função aqui
                it "NomeDoTeste1" $ do                 -- Coloque o nome do teste aqui
                        funçãoExemploR 1 3 `shouldBe` 4 -- Invoque a função do lado esquerdo e coloque a resposta esperada do lado direito.
                it "NomeDoTeste2" $ do                 -- Repita para o segundo teste
                        funçãoExemploR 0 0 `shouldBe` 0
        describe "Testes da funçãoExemploL" $ do              -- Repita para as outras funções
                it "NomeDoTeste1" $ do
                        funçãoExemploL 1 3 `shouldBe` 4
                it "NomeDoTeste2" $ do
                        funçãoExemploL 0 0 `shouldBe` 0
        describe "Teste IMC" $ do
                it "imc 1" $ do
                        imc 1.50 40 `shouldBe` "Baixo"
                it "imc 2" $ do
                        imc 1.71 60 `shouldBe` "Medio"
                it "imc 3" $ do
                        imc 1.80 100 `shouldBe` "Alto"
        describe "Inverte frase" $ do
                it "inverte frase 1" $ do
                        inverteFrase "Teste do Teste 1" `shouldBe` "1 Teste do Teste"
                it "inverte frase 2" $ do
                        inverteFrase "Abobrinha 123" `shouldBe` "123 Abobrinha"

