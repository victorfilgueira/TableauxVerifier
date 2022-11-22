{-# OPTIONS_GHC -Wno-deferred-out-of-scope-variables #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-name-shadowing #-}
{-# HLINT ignore "Redundant lambda" #-}
{-# HLINT ignore "Collapse lambdas" #-}
{-# HLINT ignore "Use splitAt" #-}
{-# OPTIONS_GHC -Wno-typed-holes #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# OPTIONS_GHC -Wno-unused-matches #-}

module Input
  ( getProgram,
    countOpenParens,
    countCloseParens,
    splitProgramsFunc,
    splitByFormulaValue,
    splitValue,
    splitAtIndex,
    getSecondProgram,
    returnSecondProgram,
    executeFunc,
    insert,
    getFullValues,
    mapInd,
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

splitAtIndex :: Int -> [Char] -> [[Char]]
splitAtIndex = \n -> \xs -> [take n xs, [xs !! max 0 n], drop n (tail xs)]

-- variant of map that passes each element's index as a second argument to f
mapInd :: (a -> Int -> b) -> [a] -> [b]
mapInd f l = zipWith f l [0 ..]

splitProgramsFunc :: String -> String -> [String]
splitProgramsFunc str =
  head
    . ( filter (not . null)
          . mapInd
            ( \y l ->
                ( if (y == '>' || y == '^' || y == 'v') && (countOpenParens (take l str) == countCloseParens (take l str))
                    then splitAtIndex l str
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
-- "F(avb)v(a^b)"

getSecondProgram :: [String] -> String
getSecondProgram list = list !! 1

returnSecondProgram :: String -> String
returnSecondProgram str = getSecondProgram (splitValue str str)

executeFunc :: String -> [String]
executeFunc str = splitProgramsFunc (returnSecondProgram str) (returnSecondProgram str)

insert :: String -> [String] -> [String]
insert str list = [val, fstList, sndList, thrList]
  where
    val = str
    fstList = head list
    sndList = head (tail list)
    thrList = last list

getFullValues :: String -> [String]
getFullValues str = insert (head (splitValue str str)) (executeFunc str)
