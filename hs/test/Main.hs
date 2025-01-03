module Main (main) where


import Test.Hspec
import Lib (program)

main :: IO ()
main = hspec $ do
  describe "program" $ do
    it "single number" $ do
      program "123" `shouldBe` Right 123
    it "addition" $ do
      program "123+456" `shouldBe` Right 579
    it "subtraction" $ do
      program "123-456" `shouldBe` Right (-333)
    it "multiplication" $ do
      program "123*456" `shouldBe` Right 56088
    it "division" $ do
      program "144/12" `shouldBe` Right 12
      program "12/15" `shouldBe` Right 0

    it "expr order" $ do
      program "123+456*2" `shouldBe` Right 1035
      program "123*456+2" `shouldBe` Right 56090
      program "123*456/2" `shouldBe` Right 28044
      program "123/456*2" `shouldBe` Right 0
      program "123/456*2+1" `shouldBe` Right 1
      program "123/456*2-1" `shouldBe` Right (-1)
      program "123/456*2*3" `shouldBe` Right 0
      program "123/456*2/3" `shouldBe` Right 0

    it "parentheses" $ do
      program "(123+456)*2" `shouldBe` Right 1158
      program "123*(456+2)" `shouldBe` Right 56334
      program "123*(456/2)" `shouldBe` Right 28044
      program "123/(456*2)" `shouldBe` Right 0
