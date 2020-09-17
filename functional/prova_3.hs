module Main(main) where
import System.IO

data Produto = Produto String Int String Int 
instance Show Produto  where
    show = \(Produto nome preco cod estq)-> (show nome) ++"\n"++(show preco) ++"\n"++ (show cod)++"\n"++ (show estq)

main :: IO()

--Main para testar as funçoes com apenas um produto, no entanto funciona com multiplos tambem.
main = do 
    novoProduto
    h <- openFile "produtos.dat" ReadMode
    prods <- produtosEmFalta h
    if prods > 0 then putStrLn "Existe produtos em falta" else putStrLn "Nao existe produtos em falta"
    hClose h

is_zerado :: Produto ->Bool
is_zerado (Produto _ _ _ quant) = quant == 0


novoProduto :: IO ()
novoProduto = do
    h <- openFile "produtos.dat" WriteMode

    putStrLn "Nome do produto: "
    nome <- getLine
    putStrLn "Preco do produto: "
    preco <- getLine
    putStrLn "Codigo de barras: "
    c_b <- getLine
    putStrLn "Quantidade em estoque: "
    quant <- getLine

    hPutStrLn h (show (Produto nome (read preco) c_b (read quant)))
    hClose h

lerProduto :: Handle->IO Produto 
lerProduto h = do
        nome <- hGetLine h
        preco <- hGetLine h
        cod <- hGetLine h
        estq <- hGetLine h
        return (Produto nome (read preco) cod (read estq)) --Nao fiz uso da derivacao Read (opcional)
        

produtosEmFalta :: Handle-> IO Int
produtosEmFalta h = do
     x <-hIsEOF h 
     if x then return 0
     else
        do
            pro <- lerProduto h

            if is_zerado pro 
             then
                do
                 zeros <- produtosEmFalta h
                 return (1+ zeros)
             else
                do
                 zeros <- produtosEmFalta h
                 return zeros
