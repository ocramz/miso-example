{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
module Main where

-- import System.Directory -- (getCurrentDirectory, listDirectory)
import Data.Time (UTCTime(..), getCurrentTime)

import Miso 
import Miso.String hiding (concat)


data Model = Off | On String deriving (Eq, Show)

data Action = Start | Print | CurrTime UTCTime deriving (Eq, Show)

updateModel act m = case act of
  Start -> noEff Off
  Print -> m <# do
    CurrTime <$> getCurrentTime
  CurrTime t -> noEff $ On $ show t

viewModel m = case m of
  Off -> div_ [] [button_ [onClick Print] [text "Current time"]]
  On t -> div_ [] [
      text (ms t)
    , button_ [onClick Start] [text "Reset"]
                  ]

main = startApp App{..} where
  model = Off
  initialAction = Start
  update = updateModel
  view = viewModel
  events = defaultEvents
  mountPoint = Nothing
  subs = []
