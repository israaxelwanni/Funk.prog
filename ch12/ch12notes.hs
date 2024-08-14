-- inc :: [Int] -> [Int]
-- inc [] = []
-- inc (n:ns) = n+1 : inc ns

-- sqr :: [Int] -> [Int]
-- sqr [] = []
-- sqr (n:ns) = n^2 : sqr ns

map' :: (a -> b) -> [a] -> [b] 
map' f [] = []
map' f (x:xs) = f x : map' f xs

inc = map (+1) 
sqr = map (^2)

class Functor f where
    fmap :: (a -> b) -> f a -> f b

instance Main.Functor Maybe where
    -- fmap :: (a -> b) -> Maybe a -> Maybe b 
    fmap _ Nothing = Nothing
    fmap g (Just x) = Just (g x)

-- ch 12.3
data Expr = Val Int | Div Expr Expr

-- unsafe eval
-- eval :: Expr -> Int
-- eval (Val n) = n
-- eval (Div x y) = eval x `div` eval y

safediv :: Int -> Int -> Maybe Int 
safediv _ 0 = Nothing
safediv n m = Just (n `div` m)

-- safe eval
-- eval :: Expr -> Maybe Int 
-- eval (Val n) = Just n
-- eval (Div x y) = case eval x of 
--                     Nothing -> Nothing
--                     Just n -> case eval y of
--                                 Nothing -> Nothing 
--                                 Just m -> safediv n m

-- eval :: Expr -> Maybe Int 
-- eval (Val n) = Just n
-- eval (Div x y) = eval x >>= (\n -> eval y >>= (\m -> safediv n m))

eval :: Expr -> Maybe Int 
eval (Val n) = Just n
eval (Div x y) = do n <- eval x
                    m <- eval y
                    safediv n m


fm :: [a -> b] -> [a] -> [b]
fm gs xs = [g x | g <- gs, x <- xs]

-- States
type State = Int
newtype ST a = S (State -> (a,State))

app :: ST a -> State -> (a,State) 
app (S st) x = st x

-- Make ST a monad
instance Prelude.Functor ST where
    fmap :: (a -> b) -> ST a -> ST b
    fmap g st = S (\s -> let (x,s') = app st s in (g x, s'))

instance Applicative ST where 
    pure :: a -> ST a
    pure x = S (\s -> (x,s))
    (<*>) :: ST (a -> b) -> ST a -> ST b 
    stf <*> stx = S (\s -> 
        let (f,s') = app stf s 
            (x,s'') = app stx s' in (f x, s''))

-- Reliable trees
data Tree a = Leaf a | Node (Tree a) (Tree a) 
            deriving Show

tree :: Tree Char
tree = Node (Node (Leaf 'a') (Leaf 'b')) (Leaf 'c')

-- Renames each leaf with a "Fresh" integer. 
-- Returns: (int of the leaf, next available int)
rlabel :: Tree a -> Int -> (Tree Int, Int) 
rlabel (Leaf _) n = (Leaf n, n+1)
rlabel (Node l r) n = (Node l' r', n'')
                    where
                        (l',n') = rlabel l n 
                        (r',n'') = rlabel r n'


