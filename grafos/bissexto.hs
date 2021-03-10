bissexto :: Int -> Bool

bissexto n
  | (mod n 400 == 0) = True
  | (mod n 4 == 0) && (mod n 100 /= 0) = True
  | otherwise = False
