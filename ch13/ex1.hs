import Control.Applicative
import Data.Char

newtype Parser a = P (String -> [(a,String)])

-- starts with reading a string "--" (if it appears)
-- then it will read until it reaches the new line character and return 'nothing'
comment :: Parser ()
comment = do 
            string "--"
            Main.many (sat (/= '\n'))
            return ()

string :: String -> Parser String 
string [] = return []
string (x:xs) = do char x
                   string xs 
                   return (x:xs)

char :: Char -> Parser Char 
char x = sat (== x)

sat :: (Char -> Bool) -> Parser Char
sat p = do x <- item
           if p x then return x else Main.empty

parse :: Parser a -> String -> [(a,String)]
parse (P p) inp = p inp

item :: Parser Char
item = P (\inp -> case inp of
            [] -> []
            (x:xs) -> [(x,xs)])

instance Functor Parser where
    -- fmap :: (a -> b) -> Parser a -> Parser b 
    fmap g p = P (\inp -> case parse p inp of
                [] -> []
                [(v,out)] -> [(g v, out)])

instance Applicative Parser where
    -- pure :: a -> Parser a
    pure v = P (\inp -> [(v,inp)])

    -- <*> :: Parser (a -> b) -> Parser a -> Parser b 
    pg <*> px = P (\inp -> case parse pg inp of
                    [] -> []
                    [(g,out)] -> parse (fmap g px) out)

instance Monad Parser where
    -- (>>=) :: Parser a -> (a -> Parser b) -> Parser b 
    p >>= f = P (\inp -> case parse p inp of
            [] -> []
            [(v,out)] -> parse (f v) out)

class Applicative f => Alternative f where
    empty :: f a
    (<|>) :: f a -> f a -> f a
    many,some :: f a -> f [a]

    many x = Main.some x Main.<|> pure []
    some x = pure (:) <*> x <*> Main.many x

instance Main.Alternative Parser where
    empty :: Parser a
    empty = P (\inp -> [])

    (<|>) :: Parser a -> Parser a -> Parser a
    p <|> q = P (\inp -> case parse p inp of
                [] -> parse q inp
                [(v,out)] -> [(v,out)])

