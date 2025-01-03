module Main where

import qualified Lib (program)

main :: IO ()
main = case Lib.program "1+2*3" of
    Left err -> print err
    Right res -> print res
