-- pure :: a -> fa
-- <*> :: f (a -> b) -> f a -> f b

-- Work out the types for the variables in the four applicative laws.

{- 
1. pure id <*> x = x

Left:
id :: a -> a
pure id :: f (a -> a)
x :: f a

Right:
f a
-}

{- 2. 
2. pure (g x) = pure g <*> pure x

Left:
x :: a
g :: a -> b
pure (g x) :: f b

Right:
pure g :: f (a -> b)
pure x :: f a
pure g <*> pure x :: f b
-}

{-
3. x <*> pure y = pure (\g -> g y) <*> x

Left:
x :: f (a -> b)
y :: a
pure y :: f a
x <*> pure y :: f b

Right:
\g -> g y :: (a -> b) -> b
pure (\g -> g y) :: f ((a -> b) -> b)
pure (\g -> g y) <*> x :: f b
-}

{-
4. x <*> (y <*> z) = (pure (.) <*> x <*> y) <*> z

Left:
x :: f (b -> c)
y :: f (a -> b)
z :: f a
y <*> z :: f b
x <*> (y <*> z) :: f c

Right:
(.) :: (b -> c) -> (a -> b) -> (a -> c)
pure (.) :: f ((b -> c) -> (a -> b) -> (a -> c))
pure (.) <*> x :: f ((a -> b) -> (a -> c))
pure (.) <*> x <*> y :: f (a -> c)
pure (.) <*> x <*> y) <*> z :: fc
-}


