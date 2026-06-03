module Day02 where

import Prelude

import Lib as Lib
import Effect (Effect)
import Data.Int as Int
import Effect.Console as Console
import Data.Array.ST (STArray)
import Data.Array.ST as ST
import Control.Monad.ST (ST)
import Control.Monad.ST as MonadST
import Data.Maybe (Maybe(..))
import Data.Maybe as Maybe
import Data.Array ((!!))
import Data.Array as Array
import Data.String (Pattern(..))
import Data.String as String
import Data.Tuple (Tuple(..))

parse :: String -> Array Int
parse = String.split (Pattern ",") >>> Array.fromFoldable >>> Array.mapMaybe Int.fromString

loop :: forall r. Int -> STArray r Int -> ST r Unit
loop i arr = do
  opCode <- ST.peek i arr
  case opCode of
    Just 1 -> execOp (+)
    Just 2 -> execOp (*)
    Just 99 -> pure unit
    _ -> pure unit
  where
  readAt :: Int -> ST r Int
  readAt pos = Maybe.fromMaybe 0 <$> ST.peek pos arr

  execOp :: (Int -> Int -> Int) -> ST r Unit
  execOp op = do
    ptrA <- readAt (i + 1)
    ptrB <- readAt (i + 2)
    ptrC <- readAt (i + 3)
    a <- readAt ptrA
    b <- readAt ptrB
    _ <- ST.poke ptrC (op a b) arr
    loop (i + 4) arr

run :: Array Int -> Array Int
run digits = MonadST.run do
  arr <- ST.thaw digits
  loop 0 arr
  ST.freeze arr

runProgram :: Array Int -> Int -> Int -> Int
runProgram digits noun verb = MonadST.run do
  arr <- ST.thaw digits
  _ <- ST.poke 1 noun arr
  _ <- ST.poke 2 verb arr
  loop 0 arr
  frozen <- ST.freeze arr
  pure (Maybe.fromMaybe 0 $ frozen !! 0)

getNounAndVerb :: Array Int -> Int -> Maybe (Tuple Int Int)
getNounAndVerb digits target = go 0 0
  where
  go :: Int -> Int -> Maybe (Tuple Int Int)
  go noun verb
    | noun > 99 = Nothing
    | verb > 99 = go (noun + 1) 0
    | runProgram digits noun verb == target = Just (Tuple noun verb)
    | otherwise = go noun (verb + 1)

main :: Effect Unit
main = do
  text <- Lib.readFile "inputs/day2.txt"
  let result = runProgram (parse text) 12 2
  Console.log $ "Part 1 - " <> show (result)

  let nounAndVerb = getNounAndVerb (parse text) 19690720
  case nounAndVerb of
    Just (Tuple noun verb) -> do
      Console.log $ "Part 2 - " <> show (100 * noun + verb)
    Nothing -> Console.log "Part 2 - Solution failed"
