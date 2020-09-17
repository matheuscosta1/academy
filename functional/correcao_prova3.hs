module Main (main) where
import System.IO

data Produto = Produto String Int String Int
instance Show Produto where
    show = \(Produto nome preco cod estoque)-> (show nome)++"\n"++(show preco)++"\n"++(show cod)++"\n"++(show estoque)
	
main :: IO()
main = do
  novoProduto
  h <- openFile "produtos.dat" ReadMode
  produtos <- produtosEmFalta h
  if produtos > 0 then putStrLn "Existe produto em falta" else putStrLn"Nao existe produtos em falta"
  hClose h

is_zerado :: Produto -> Bool
is_zerado (Produto _ _ _ quantidade) = quantidade == 0

novoProduto :: IO ()
novoProduto = do
  h <- openFile "produtos.dat" WriteMode
  
  putStrLn "Nome do produto: "
  nome <- getLine
  putStrLn "Preco do produto: "
  preco <- getLine
  putStrLn "Codigo de barras: "
  cod_bar <- getLine
  putStrLn "Quantidade em estoque: "
  quantidade <- getLine
  
  hPutStrLn h (show (Produto nome (read preco) cod_bar (read quantidade)))
  hClose h

lerProduto :: Handle -> IO Produto
lerProduto h = do
  nome <- hGetLine h
  preco <- hGetLine h
  cod <- hGetLine h
  estoque <- hGetLine h
  return (Produto nome (read preco) cod (read estoque))
  
produtosEmFalta :: Handle -> IO Int
produtosEmFalta h = do
  x <- hIsEOF h
  if x then return 0
  else   
    do 
	   pro <- lerProduto h
	   
	   if is_zerado pro then 
	                     do 
						  zeros <- produtosEmFalta h
						  return (1+zeros)
                           else
                             do
                              zeros <- produtosEmFalta h
                              return zeros