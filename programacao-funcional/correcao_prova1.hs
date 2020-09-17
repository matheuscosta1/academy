import Prelude hiding ()

transforma :: [Int] -> [String]
transforma [] = []
transforma (x:xs) = [(show(x`div`100))++"."++(show(x`rem`100))]++transforma xs

transforma1 :: [Int] -> [String]
transforma1 lista = [x| x<-transforma lista] 

pertence :: Char -> [Char] -> Bool
pertence a [] = False
pertence a (x:xs) = if (a == x) then True else pertence a xs  
 
devolvePalavra :: String -> String
devolvePalavra [] = ""
devolvePalavra (x:xs) = if not(pertence ' ' [x]) then [x]++devolvePalavra xs else ""

removePalavra :: String -> String
removePalavra [] = ""
removePalavra (x:xs) = if (pertence ' ' [x]) then " "++xs else removePalavra xs

removeEspaco :: String -> String
removeEspaco [] = ""
removeEspaco (x:xs) = if (pertence ' ' [x]) then ""++xs else removeEspaco xs