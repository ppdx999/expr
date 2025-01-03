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

-- expr ::= term { ('+' term) | ('-' term) }
expr :: Parser Int
expr = eval term $ many $
        char '+' *> apply (+) term
    <|> char '-' *> apply (-) term

-- term ::= factor { ('*' factor) | ('/' factor) }
term :: Parser Int
term = eval factor $ many $
        char '*' *> apply (*) factor
    <|> char '/' *> apply div factor

-- factor ::= number | '(' expr ')'
factor :: Parser Int
factor = number <|> between (char '(') (char ')') expr

number :: Parser Int
number = read <$> many1 digit
