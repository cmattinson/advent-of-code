module Lib where

import Prelude

import Data.List (List)
import Data.List as List
import Data.String (Pattern(..), split)
import Effect (Effect)

foreign import readFile :: String -> Effect String

readLines :: String -> Effect (List String)
readLines path = do
  content <- readFile path
  pure $ List.fromFoldable $ split (Pattern "\n") content
