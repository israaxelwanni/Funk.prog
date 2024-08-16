{-
redex = An expression that has the form of a function applied to one or more arguments 
        that can be ‘reduced’ by performing the application

1. 
1 + (2*3)

innermost = 2 * 3
outermoast = 2 * 3
total = 2 redexes, 1 inner & 1 outer 

(2*3 is both inner- and outermoast, because we need the reduction of 2*3 to be
able to evaluate 1 + (2*3))

2. 
(1+2) * (2+3)

innermoast = 1 + 2
outermoast = 2 + 3
total = 3 redexes, 1 inner & 1 outer

(in haskell the innermoast redex is that redex that is to the left; and right for 
outermoast)

3. 
fst (1+2, 2+3)

innermoast = 1 + 2 && 2 + 3
outermoast = fst (.., ..)
total = 3 redexes, 2 inner & 1 outer

4. 
(\x -> 1 + x) (2*3)

innermoast = 2 * 3
outermoast = (\x -> 1 + x) 6
total = 2 redexes, 1 inner & 1 outer
-}
