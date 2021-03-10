module Acronym (abbreviate) where

nonAlpha :: String -> String
nonAlpha [] = []
nonAlpha (x:xs)
  | x `elem` ['A'..'Z']  = x : nonAlpha xs
  | otherwise                                   = ' ' : nonAlpha xs

camelCase :: String -> String
camelCase [] = []
camelCase [x] = [x]
camelCase (x:y:xs)
  | x `elem` ['a'..'z'] && y `elem` ['A'..'Z']  = x : ' ' : y : camelCase xs
  | otherwise                                   = x : camelCase (y:xs)

toUpper :: Char -> Char
toUpper c
  | c `elem` ['a'..'z']  = toEnum (fromEnum c - fromEnum 'a' + fromEnum 'A') :: Char
  | otherwise            = c

abbreviate :: String -> String
abbreviate xs = map (\x -> toUpper (x !! 0)) $ (words . camelCase . nonAlpha) xs
