import Data.Array

mat = array ((1,1),(2,3)) [((1,1),4),((1,2),0),((1,3),8),((2,1),7),((2,2),1),((2,3),7)]

quadrado x = x * x

aplicaFuncaoEmUmaMatriz funcao mat = array (bounds mat) [((i,j), funcao (mat!(i,j))) | (i,j) <- range (bounds mat)]
