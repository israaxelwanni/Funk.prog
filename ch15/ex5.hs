data Tree a = Leaf | Node (Tree a) a (Tree a) 
            deriving Show

{-
create a function that takes a value and constructs an infinite (or recursively 
repeating) binary tree where every node contains that value.
-}
repeat' :: a -> Tree a
repeat' x = Node (repeat' x) x (repeat' x)

{-
define a function that limits the depth of the binary tree to a certain number 
of levels (similar to how take limits the length of a list).
-}
take' :: Int -> Tree a -> Tree a
take' 0 _ = Leaf
take' _ Leaf = Leaf
take' n (Node l v r) = Node (take' (n - 1) l) v (take' (n - 1) r)

{-
combine repeat and take for trees to create a tree that has a specific depth, 
where every node contains the same value.
-}
replicate' :: Int -> a -> Tree a 
replicate' n = take' n . repeat'