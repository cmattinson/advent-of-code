module Test.Day02 where

import Prelude

import Day02 (parse, run)

import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)

spec :: Spec Unit
spec = describe "Day 2" do
  describe "run" do
    it "processes the example program" do
      let input = "1,9,10,3,2,3,11,0,99,30,40,50"
      let expected = [ 3500, 9, 10, 70, 2, 3, 11, 0, 99, 30, 40, 50 ]
      run (parse input) `shouldEqual` expected

