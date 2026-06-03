module Test.Main where

import Prelude

import Effect (Effect)
import Test.Day01 as Day01
import Test.Day02 as Day02
import Test.Spec (describe)
import Test.Spec.Reporter (consoleReporter)
import Test.Spec.Runner.Node (runSpecAndExitProcess)

main :: Effect Unit
main = runSpecAndExitProcess [ consoleReporter ] do
  describe "Advent of Code 2019" do
    Day01.spec
    Day02.spec
