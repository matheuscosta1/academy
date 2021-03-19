import Data.Array

mat:: Array (Int,Int) Int

mat = array ((1,1),(2,2)) [((1,1),2),((1,2),2),((2,1),3),((2,2),4)]

matrizTransposta :: Array (Int,Int) Int -> Array (Int,Int) Int

matrizTransposta a = array ((li,ui), (lj,uj)) [((i,j),a!(j,i)) | i <- [li..lj], j <- [ui..uj]] where ((li,ui), (lj,uj)) = bounds a
