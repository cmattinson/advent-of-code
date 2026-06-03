module Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)

main :: Effect Unit
main = do
  log "Advent of Code 2019 - PureScript"
  log ""
  log "Run a specific day with:"
  log "  npm run day<N>"
  log ""
  log "Or directly:"
  log "  npx spago run --main Day<N>"
