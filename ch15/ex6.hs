{-
- start with an initial approximation to the result;
- given the current approximation a, the next approximation is defined by the 
function 'next'
- repeat the second step until the two most recent approximations are within 
some desired distance of one another, at which point the most recent value 
is returned as the result.

- first produce an infinite list of approximations using the library function iterate
- For simplicity, take the number 1.0 as the initial approximation, and 0.00001 as 
the distance value.
-}

list n = iterate (next n) 1.0
    -- [x | (x,y) <- zip xs (tail xs), abs (x - y) <= 0.00001]
    -- where
    --     xs = iterate next 1.0

-- n = the number we want to find the square root of
next n a = (a + n/a) / 2;

sqroot :: Double -> Double
sqroot d = head [x | (x,y) <- zip xs (tail xs), abs (x - y) < 0.00001]
        where
            xs = list d

