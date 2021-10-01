pertence :: Eq t => t -> [t] -> Bool
pertence a [] = False
pertence f (x:xs) = if (f == x) then True else pertence f xs  

uniaoListas :: Eq a => [a] -> [a] -> [a]
uniaoListas [] a = a
uniaoListas (x:xs) a = if pertence x a then uniaoListas xs a
                                          else x : uniaoListas xs a

removeRepetidos [] lista = []
removeRepetidos lista [] = lista
removeRepetidos (a:x) (b:y)
    | elem a (b:y) = removeRepetidos x (b:y)
    | otherwise = a : removeRepetidos x (b:y)