import Data.Array


numeradores:: Integer -> Double -> Array Integer Double
numeradores n x = array (1, n) [(i,x^i)| i <- [1..n]]

fatorial:: Integer -> Integer
fatorial n
  | n == 0 = 1
  | otherwise = n * fatorial(n-1)

taylor:: Integer -> Double -> Double
taylor n x = 1 + (foldr1 (+) [(((numeradores n x)!a)) / (fromIntegral (fatorial a)) | a <- [1..n]])
