module Main where

import qualified Lib (add)

main :: IO ()
main = do
  print $ Lib.add 1 2
