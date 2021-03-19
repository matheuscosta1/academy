import Data.List (replicaGenerica)

simbolos = [(1000,"M"), (900,"CM"), (500,"D"), (400,"CD"), (100,"C"), (90,"XC"), (50,"L"), (40,"XL"), (10,"X"), (9,"IX"), (5,"V"), (4,"IV"), (1,"I")]

converteDecimalParaRomano :: Integer -> String
converteDecimalParaRomano 0 = "N"
converteDecimalParaRomano x | x > 0 = snd $ foldl f (x,[]) simbolos
  where f (n,s) (rn, rs) = (l, s ++ concat (replicaGenerica k rs))
                      where (k,l) = divMod n rn
