
formula = "(avb)v(a^b)"

ajeita :: [Char] -> ([Char], Char, [Char])
ajeita str = (prim, op, seg)
    where prim = take 5 str
          op = last (take 6 str)
          seg = reverse (take 5 (reverse str))

x = ajeita formula

prim :: ([Char], Char, [Char]) -> [Char]
prim (a,_,_) = a

operador :: ([Char], Char, [Char]) -> Char
operador (_,b,_) = b

seg :: ([Char], Char, [Char]) -> [Char]
seg (_,_,c) = c

p = prim x
op = operador x
s = seg x


{-regra :: Char -> Char -> ((Char, [Char]), (Char, [Char]))
regra p op s
    | op == 'v' = (('V', prim), ('V', seg))
    otherwise error "Empty"-}


input :: IO ()
input = do
    putStrLn ("Digite sua formula: ")
    entrada <- getLine
    print ("formula = " ++ entrada)
    