primos :: [Int]
primos = f [2..] where f (p : ns) = p : f [n | n <- ns, n `mod` p /= 0]

fatoresPrimos :: Int -> [Int]
fatoresPrimos m = f m (head primos) (tail primos) where
  f m n ns
    | m < 2 = [] 
    | m `mod` n == 0 = n : f (m `div` n) n ns
    | otherwise = f m (head ns) (tail ns)

