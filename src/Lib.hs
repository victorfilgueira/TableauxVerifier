{-# OPTIONS_GHC -Wno-deferred-out-of-scope-variables #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-unused-matches #-}

module Lib
  ( getProgram,
    increment,
    split,
    splitPrograms,
    isBalanced,
    countOpenParens,
    countCloseParens,
    splitProgramsWithParams,
  )
where

getProgram :: IO ()
getProgram = do
  print "Digite a formula para ser verificada: "
  line <- getLine
  print line

increment :: Int -> Int
increment x = x + 1

-- getAllPrograms :: [Char] -> Int -> Int -> Int -> Int -> [Char]
-- getAllPrograms program start opennedBracket closedBracket level =
--   if start <= length program
--     then if get program start == "("
--       then increment opennedBracket
--     else
--       if get program start == ")"
--         then increment closeBracket
--       else
--         if ((get program start == "^") || (get program start == "v") || (get program start == ">") || (get program start == "^")) && opennedBracket == closedBracket
--           then getAllPrograms program (start + 1) 0 0 0
--   else
--     increment start

split :: [Char] -> [[Char]]
split str = case break (== '>') str of
  (a, '>' : b) -> a : split b
  (a, "") -> [a]

splitPrograms :: String -> Char -> [String]
splitPrograms [] delim = [""]
splitPrograms (c : cs) delim
  | c == delim = "" : rest
  | otherwise = (c : head rest) : tail rest
  where
    rest = splitPrograms cs delim

countOpenParens :: String -> Int
countOpenParens str = length $ filter (== '(') str

countCloseParens :: String -> Int
countCloseParens str = length $ filter (== ')') str

isBalanced :: String -> Bool
isBalanced str = countOpenParens str == countCloseParens str

splitProgramsWithParams :: String -> Char -> [String]
splitProgramsWithParams str c =
  if isBalanced str
    then splitPrograms str c
    else []
