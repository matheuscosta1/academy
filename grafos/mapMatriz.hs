import Data.Array

quadrado x = x * x

somaMat quadrado mat = array (bounds mat)
                    [((i,j), quadrado (mat!(i,j))) | (i,j) <- range (bounds mat)]
