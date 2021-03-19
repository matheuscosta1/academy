module Acronym (abreviacao) where

semCaractereAlpha :: String -> String
semCaractereAlpha [] = []
semCaractereAlpha (x:xs)
  | x `elem` ['A'..'Z']  = x : semCaractereAlpha xs
  | otherwise = ' ' : semCaractereAlpha xs

camelCase :: String -> String
camelCase [] = []
camelCase [x] = [x]
camelCase (x:y:xs)
  | y `elem` ['A'..'Z'] && x `elem` ['a'..'z']  = x : ' ' : y : camelCase xs
  | otherwise = x : camelCase (y:xs)

convertParaMaiusculo :: Char -> Char
convertParaMaiusculo c
  | c `elem` ['a'..'z']  = toEnum (fromEnum c - fromEnum 'a' + fromEnum 'A') :: Char
  | otherwise = c

abreviacao :: String -> String
abreviacao xs = map (\x -> convertParaMaiusculo (x !! 0)) $ (words . camelCase . semCaractereAlpha) xs
