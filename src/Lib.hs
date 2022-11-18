{-# OPTIONS_GHC -Wno-deferred-out-of-scope-variables #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-name-shadowing #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# OPTIONS_GHC -Wno-unused-matches #-}

{-# HLINT ignore "Redundant lambda" #-}
{-# HLINT ignore "Collapse lambdas" #-}
{-# HLINT ignore "Use splitAt" #-}

module Lib
  ( getProgram,
    countOpenParens,
    countCloseParens,
    indexOf,
    getIndexOf,
    getFirstPart,
    splitProgramsFunc,
  )
where

getProgram :: IO ()
getProgram = do
  print "Digite a formula para ser verificada: "
  line <- getLine
  print line

countOpenParens :: String -> Int
countOpenParens str = length $ filter (== '(') str

countCloseParens :: String -> Int
countCloseParens str = length $ filter (== ')') str

indexOf :: (Eq a) => a -> [a] -> Int
indexOf n [] = -1
indexOf n (x : xs)
  | n == x = 0
  | otherwise = case n `indexOf` xs of
      -1 -> -1
      i -> i + 1

getIndexOf :: Char -> String -> String -> Int
getIndexOf c str = head . (filter (> -1) . map (\y -> if y == c then indexOf y str else -1))

getFirstPart :: Char -> String -> String -> String
getFirstPart c str = head . (filter (not . null) . map (\y -> if y == c then take (getIndexOf c str str) str else []))

splitAtIndex :: Int -> [Char] -> ([Char], [Char])
splitAtIndex = \n -> \xs -> (take n xs, drop (n + 1) xs)

splitProgramsFunc :: String -> String -> (String, String)
splitProgramsFunc str =
  head
    . ( filter (not . null . fst)
          . map
            ( \y ->
                ( if (y == '>' || y == '^' || y == 'v') && (countOpenParens (getFirstPart y str str) == countCloseParens (getFirstPart y str str))
                    then splitAtIndex (getIndexOf y str str) str
                    else ("", "")
                )
            )
      )
