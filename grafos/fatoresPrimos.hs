divisores1 :: Int -> [Int]
divisores1 n = [x | x <- [1..n], mod n x == 0]

primo :: Int -> Bool
primo n = (divisores1 n == [1,n])

primos :: Int -> [Int]
primos n = [x | x <- [2..n], primo x]


primes :: [Int]
primes = f [2..] where f (p : ns) = p : f [n | n <- ns, n `mod` p /= 0]

factors :: Int -> [Int]
factors m = f m (head primes) (tail primes) where
  f m n ns  
    | m < 2 = [] 
    | m `mod` n == 0 = n : f (m `div` n) n ns
    | otherwise = f m (head ns) (tail ns)

