-- File containing the main function of this program.

module Root.Src.Main where
import Distribution.Parsec.LexerMonad (getInput)

-- Import the module that defines the function maxElement





pegaAltura:: IO Float
pegaAltura = do
    print "Digite a sua altura"
    altura <- getLine
    return (read altura)

pegaPeso:: IO Float
pegaPeso = do
    print "Digite o seu peso"
    peso <- getLine
    return (read peso)

imc:: Float -> Float -> String
imc altura peso
    | valor < 18.5 = "Baixo"
    | valor >= 18.5 && valor <= 24.9 = "Medio"
    | otherwise = "Alto"
    where
        valor = peso/(altura*altura)

leEntrada:: IO String
leEntrada = do
    print "Digite uma frase"
    frase <- getLine
    return (read frase)


inverteFrase:: String-> String
inverteFrase string = unwords $ reverse $ words string

-- The main entry point.


data Árvore a = Nada | Nó a (Árvore a) (Árvore a)  deriving (Show)

adicionar :: (Eq a, Ord a) => a -> Árvore a -> Árvore a
adicionar novoDado Nada = Nó novoDado Nada Nada
adicionar novoDado árvore@(Nó dadoExistente ae ad)
    | novoDado == dadoExistente = árvore
    | novoDado < dadoExistente  = Nó dadoExistente (adicionar novoDado ae) ad
    | otherwise                 = Nó dadoExistente ad (adicionar novoDado ad)

impressãoEmOrdem :: (Show a) => Árvore a -> String
impressãoEmOrdem Nada = "."
impressãoEmOrdem (Nó dado ae ad) = impressãoEmOrdem ae ++ show dado ++ impressãoEmOrdem ad


pegaValorParaAdicionarNaArvore :: Árvore Int -> IO (Árvore Int)
pegaValorParaAdicionarNaArvore arvore = do
    print "Digite um valor inteiro"
    inteiro <- getLine
    let number = (read inteiro :: Int)
    let novaArvore = adicionar number arvore
    if number == -1 then return novaArvore else pegaValorParaAdicionarNaArvore novaArvore
{-
>>> arv = adicionar 3 (adicionar 4 (adicionar 10 (adicionar 1 (adicionar 2 (adicionar 3 (adicionar 7 Nada))))))

>>> arv
/tmp/extra-file-58556222104816-92024-71: commitBuffer: invalid argument (invalid character)

>>> impressãoEmOrdem arv
".3.4.7.10."
-}

main :: IO ()
main = do
        -- We print a heading and make it bigger using HTML formatting.

        altura <- pegaAltura
        print $ "Sua altura é " ++ show altura
        peso <- pegaPeso
        print $ "Seu peso é " ++ show peso
        print $ "Seu IMC é " ++ show (imc altura peso)
        entrada <- leEntrada
        print $ "Inverte frase: " ++ show (inverteFrase entrada)
        let arvore = Nada
        leArvore <- pegaValorParaAdicionarNaArvore arvore
        print $ "Arvore: " ++ show (impressãoEmOrdem leArvore)