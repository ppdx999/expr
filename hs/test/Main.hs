module Main (main) where


import Test.Hspec
import Lib (add)

main :: IO ()
main = hspec $ do
  describe "add" $ do
    it "adds two numbers" $ do
      add 1 2 `shouldBe` 3
    it "adds two negative numbers" $ do
      add (-1) (-2) `shouldBe` (-3)
    it "adds a positive and a negative number" $ do
      add 1 (-2) `shouldBe` (-1)
    it "adds a negative and a positive number" $ do
      add (-1) 2 `shouldBe` 1

