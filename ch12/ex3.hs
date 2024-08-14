-- instance Applicative ((->) a) where
pure :: b -> (a -> b)
pure = const 

(<*>) :: (a -> b -> c) -> (a -> b) -> (a -> c)
-- f a b = c & g a = b => f a (g a) = c
f <*> g = \x -> f x (g x)