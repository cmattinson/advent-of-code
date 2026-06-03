module Day01 where

import Prelude

import Data.Foldable (sum)
import Data.List (mapMaybe)
import Data.Int (fromString)
import Effect (Effect)
import Effect.Console (log)
import Lib (readLines)

fuelRequirement :: Int -> Int
fuelRequirement mass =
  (div mass 3) - 2

totalFuelRequirement :: Int -> Int
totalFuelRequirement mass =
  case fuelRequirement mass of
    f | f <= 0 -> 0
    f -> f + totalFuelRequirement f

main :: Effect Unit
main = do
  lines <- readLines "inputs/day1.txt"
  let fuel = lines # mapMaybe fromString # map fuelRequirement # sum
  let totalFuel = lines # mapMaybe fromString # map totalFuelRequirement # sum
  log $ "Part 1 - " <> show fuel
  log $ "Part 2 - " <> show totalFuel
