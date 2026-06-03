module Test.Day01 where

import Prelude

import Day01 (fuelRequirement, totalFuelRequirement)

import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)

spec :: Spec Unit
spec = describe "Day 1" do
  describe "fuelRequirement" do
    it "calculates fuel for mass 12" do
      fuelRequirement 12 `shouldEqual` 2
    it "calculates fuel for mass 14" do
      fuelRequirement 14 `shouldEqual` 2
    it "calculates fuel for mass 1969" do
      fuelRequirement 1969 `shouldEqual` 654
    it "calculates fuel for mass 100756" do
      fuelRequirement 100756 `shouldEqual` 33583

  describe "totalFuelRequirement" do
    it "calculates total fuel for mass 14" do
      totalFuelRequirement 14 `shouldEqual` 2
    it "calculates total fuel for mass 1969" do
      totalFuelRequirement 1969 `shouldEqual` 966
    it "calculates total fuel for mass 100756" do
      totalFuelRequirement 100756 `shouldEqual` 50346
