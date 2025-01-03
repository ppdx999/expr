module Lib
( program
) where

import Text.Parsec
import Text.Parsec.String (Parser)

program :: String -> Either ParseError Int
program = parse expr ""

eval :: Parser a -> Parser [a -> a] -> Parser a
eval m fs = foldl (\x f -> f x) <$> m <*> fs

apply :: (a -> a -> a) -> Parser a -> Parser (a -> a)
apply f m = flip f <$> m

expr :: Parser Int
expr = eval term $ many $
        char '+' *> apply (+) term
    <|> char '-' *> apply (-) term

term :: Parser Int
term = eval number $ many $
        char '*' *> apply (*) number
    <|> char '/' *> apply div number

number :: Parser Int
number = read <$> many1 digit
