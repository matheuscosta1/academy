import Stack

size :: Stack a -> Int
size s 
 | isEmpty s = 0
 | otherwise = 1 + size (pop s)