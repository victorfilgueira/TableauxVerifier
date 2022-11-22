{-# OPTIONS_GHC -Wno-deferred-out-of-scope-variables #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-name-shadowing #-}
{-# HLINT ignore "Redundant lambda" #-}
{-# HLINT ignore "Collapse lambdas" #-}
{-# HLINT ignore "Use splitAt" #-}
{-# OPTIONS_GHC -Wno-typed-holes #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# OPTIONS_GHC -Wno-unused-matches #-}

module Lib
  ( getProgram,
    countOpenParens,
    countCloseParens,
    indexOf,
    getIndexOf,
    getFirstPart,
    splitProgramsFunc,
    splitByFormulaValue,
    splitValue,
    splitAtIndex,
    getSecondProgram,
    returnSecondProgram,
    executeFunc,
    getFirstProgram,
    insert,
    getFullValues,
    -- splitProgramsFunc2,
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

splitAtIndex :: Int -> [Char] -> [[Char]]
splitAtIndex = \n -> \xs -> [take n xs, [xs !! max 0 n], drop n (tail xs)]

splitProgramsFunc :: String -> String -> [String]
splitProgramsFunc str =
  head
    . ( filter (not . null)
          . map
            ( \y ->
                ( if (y == '>' || y == '^' || y == 'v') && (countOpenParens (getFirstPart y str str) == countCloseParens (getFirstPart y str str))
                    then splitAtIndex (getIndexOf y str str) str
                    else []
                )
            )
      )

splitByFormulaValue :: String -> Char -> [String]
splitByFormulaValue [] delim = [""]
splitByFormulaValue (c : cs) delim
  | c == delim = [c] : rest
  | otherwise = (c : head rest) : tail rest
  where
    rest = splitByFormulaValue cs delim

splitValue :: String -> [Char] -> [String]
splitValue str = head . (filter (not . null) . map (\y -> if y == 'V' || y == 'F' then splitByFormulaValue str y else []))

-- v((avb),(b^a))
-- v(v(a,b),^(b,a))
-- "Vb>(a^(bva))"

getSecondProgram :: [String] -> String
getSecondProgram list = list !! 1

getFirstProgram :: [a] -> a
getFirstProgram = head

returnSecondProgram :: String -> String
returnSecondProgram str = getSecondProgram (splitValue str str)

executeFunc :: String -> [String]
executeFunc str = splitProgramsFunc (returnSecondProgram str) (returnSecondProgram str)

insert :: a -> [a] -> [a]
insert str [a] = [str, a]

getFullValues :: String -> [String]
getFullValues str = insert (getFirstProgram (splitValue str str)) (executeFunc str)