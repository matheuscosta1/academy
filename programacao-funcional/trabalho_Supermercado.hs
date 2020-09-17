import Prelude hiding(replicate)

--putStr faz quebrar a linha; necessito parentesear toda a String

type Nome = String
type Preco = Int
type CodBar = Int
type ListaDeCodigos = [CodBar]
type Recibo = [(Nome, Preco)]
type BaseDeDados = [(CodBar, Nome, Preco)]

listaDeProdutos :: BaseDeDados
listaDeProdutos = [ (1234,"Oleo DoBom,1l",195),
    (4756,"Chocolate Cazzeiro,250Kg",180),
    (3216,"Arroz DoBom,5Kg",213),
    (5823,"Balas Pedregulho,1Kg",379),
    (4719,"Queijo Mineirim,1Kg",449),
    (6832,"Iogurte Maravilha,1Kg",499),
    (1112,"Rapadura QuebraDente,1Kg",80),
    (1111,"Sal Donorte,1Kg", 221),
    (1113,"Cafe DoBom,1Kg", 285),
    (1115,"Biscoito Bibi,1Kg", 80),
    (3814,"Sorvete QGelo,11Kg", 695)] 

getCodBarras :: (CodBar,Nome, Preco) -> CodBar
getCodBarras (a,_,_) = a

getPreco :: (CodBar, Nome, Preco) -> Preco
getPreco (_,_,a) = a

getNome :: (CodBar, Nome, Preco) -> Nome
getNome (_,a,_) = a

getNomePreco :: (CodBar, Nome, Preco) -> (Nome,Preco)
getNomePreco (_,a,b) = (a,b)

formataCentavos :: Preco -> String
formataCentavos x = (show(x `div` 100))++"."++(show(x`rem`100))

--Recibo = [(Nome, Preco)]
geraTotal :: Recibo -> Preco
geraTotal [] = 0
geraTotal (x:xs) = snd x + geraTotal xs -- first e second servem para mexer com tupla

achaItem :: CodBar -> BaseDeDados -> (Nome, Preco)
achaItem _ [] = error"Codigo de barras inexistente"
achaItem y (x:xs) 
  | (y == getCodBarras x) = (getNome x, getPreco x)
  | otherwise = achaItem y xs

--Usando as funções formataLinhas, geraTotal e formataTotal, defina a função
--formataRecibo :: TipoDoRecibo -> String  
--geralTotal :: recibo -> preco; formataTotal preco -> string; formataLinhas   
--formataRecibo :: TipoDoRecibo -> String
  
fazRecibo :: ListaDeCodigos -> BaseDeDados -> [(Nome,Preco)]
fazRecibo [] x = []
fazRecibo (y:ys) x = [achaItem (y) (x)] ++ (fazRecibo ys x)

formataTotal :: Preco -> String
formataTotal x = "Total"++(replicate (tamanho1 x) '.')++formataCentavos x

--formatarLinha (a,b)=  a++ "......" ++ (formataCentavos b)    
tamanho1 :: Preco -> Int
tamanho1 x = tamLinha - (length(formataCentavos x)+5)

tamanho :: (Nome,Preco) -> Int
tamanho (a,b) = tamLinha - length(a++(formataCentavos b))
  
tamLinha :: Int
tamLinha = 30

replicate :: Int -> Char -> String 
replicate 1 _ = ""
replicate n a = [a]++(replicate (n-1) a)
   
formatarLinha :: (Nome,Preco) -> String
formatarLinha (a,b)= a++((replicate (tamanho(a,b))('.')))++(formataCentavos b)++"\n"

--aplica para cada nome e preço
--recibo [(Nome,Preco)]  --formatarLinha :: (Nome,Preco) -> String
formataLinhas :: Recibo -> String
formataLinhas [] = ""
formataLinhas (x:xs)= (formatarLinha x)++(formataLinhas xs)
  
--formataTotal :: Preco -> String
-- geraTotal :: Recibo -> Preco -- Recibo [(Nome,Preco)]
-- formataLinhas :: Recibo -> String
-- formataLinhas = uma lista de (Nome, Preco); geraTotal = soma uma lista de (Nome,*Preco*) e formataTotal = coloca "." e converte centavos
formataRecibo :: Recibo -> String
formataRecibo [] = ""
formataRecibo (x:xs) = formataLinhas (x:xs) ++formataTotal (geraTotal(x:xs))++"\n"

-- fazRecibo e formataRecibo
geraRecibo :: ListaDeCodigos -> BaseDeDados -> String
geraRecibo l x= "\nAs suas compras na loja, foram:\n\n"++formataRecibo(fazRecibo l x)++"\n"

-- para fazer chamada no programa, use: putStr(geraRecibo[lista de codigos -- base de dados] listaDeProdutos)

-- parte de testes, não inclusa no desenvolvido do problema.
getRecibo :: (CodBar, Nome, Preco) -> (Nome,Preco)
getRecibo (_,a,b) = (a,b)

listaCodigos :: BaseDeDados -> String
listaCodigos [] = ""
listaCodigos (x:xs) = (show (getCodBarras x))++" "++(listaCodigos xs)

listaRecibos :: BaseDeDados -> String
listaRecibos [] = ""
listaRecibos (x:xs) = (show (getRecibo x))++" "++(listaRecibos xs)