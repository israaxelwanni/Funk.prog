-- show how the evaluation of mult 3 4 can be broken down into four separate steps.
mult = \x -> (\y -> x * y)

{-
mult 3 4 
v v v   (applying mult)
\x -> (\y -> x * y) 3 4
v v v   (applying 3 to x)
(\y -> 3 * y) 4
v v v   (applying 4 to y)
3 * 4
v v v   (applying *)
12 

-}