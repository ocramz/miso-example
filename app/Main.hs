{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
module Main where

-- import System.Directory -- (getCurrentDirectory, listDirectory)
import Data.Time (UTCTime(..), getCurrentTime)

import Miso 
import Miso.String hiding (concat)



type Model = String

data Action = Start
  | Print
  | CurrTime String
  deriving (Eq, Show)

updateModel :: Action -> Model -> Effect Action Model
updateModel act m = case act of
  Start -> noEff "Start"
  Print -> m <# do
    CurrTime . show <$> getCurrentTime
  CurrTime str -> noEff str

main = startApp App{ .. } where
  model = "X"
  initialAction = Start
  update = updateModel
  view = viewModel
  events = defaultEvents
  mountPoint = Nothing
  subs = []

viewModel :: Model -> View Action
viewModel x = div_ [] [
    button_ [ onClick Print ] [ text "Current time" ]
  , text (ms (show x))
  , button_ [ onClick Start ] [ text "Reset"]
                      ]


-- 1 

-- -- | Type synonym for an application model
-- type Model = Int

-- -- | Sum type for application events
-- data Action
--   = AddOne
--   | SubtractOne
--   | NoOp
--   | SayHelloWorld
--   deriving (Show, Eq)

-- -- | Entry point for a miso application
-- main :: IO ()
-- main = startApp App {..}
--   where
--     initialAction = SayHelloWorld -- initial action to be executed on application load
--     model  = 0                    -- initial model
--     update = updateModel          -- update function
--     view   = viewModel            -- view function
--     events = defaultEvents        -- default delegated events
--     mountPoint = Nothing          -- mount point for miso on DOM, defaults to body
--     subs   = []                   -- empty subscription list

-- -- | Updates model, optionally introduces side effects
-- updateModel :: Action -> Model -> Effect Action Model
-- updateModel AddOne m = noEff (m + 3)
-- updateModel SubtractOne m = noEff (m - 1)
-- updateModel NoOp m = noEff m
-- updateModel SayHelloWorld m = m <# do
--   putStrLn "Hello World" >> pure NoOp

-- -- | Constructs a virtual DOM from a model
-- viewModel :: Model -> View Action
-- viewModel x = div_ [] [
--    button_ [ onClick AddOne ] [ text "+" ]
--  , text (ms (show x))
--  , button_ [ onClick SubtractOne ] [ text "-" ]
--  ]


