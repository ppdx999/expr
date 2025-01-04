module Main where

import qualified Lib (program)

main :: IO ()
main = interact go

go :: String -> String
go input = case Lib.program input of
    Left err -> show err
    Right res -> show res
