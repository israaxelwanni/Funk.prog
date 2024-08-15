
data Expr a = Var a | Val Int | Add (Expr a) (Expr a) 
                deriving Show

instance Functor Expr where
    fmap :: (a -> b) -> Expr a -> Expr b
    fmap g (Var a) = Var (g a)
    fmap g (Val i) = Val i
    fmap g (Add e f) = Add (fmap g e) (fmap g f)

instance Applicative Expr where
    pure :: a -> Expr a
    pure e = Var e

    (<*>) :: Expr (a -> b) -> Expr a -> Expr b
    (Val i) <*> _ = Val i
    (Var a) <*> e = fmap a e
    (Add a b) <*> e = Add (a <*> e) (b <*> e)

instance Monad Expr where
    (>>=) :: Expr a -> (a -> Expr b) -> Expr b
    (Val i) >>= _ = Val i
    (Var a) >>= f = f a
    (Add a b) >>= f = Add (a >>= f) (b >>= f) 