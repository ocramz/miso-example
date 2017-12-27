{-# LANGUAGE OverloadedStrings, RecordWildCards #-}
module Main where


import System.Directory -- (getCurrentDirectory, listDirectory)
import Data.Time (UTCTime(..), getCurrentTime)

import Miso 
import Miso.String hiding (concat, head)




data Model = Off | On String deriving (Eq, Show)

data Action = Start | Print | CurrDir String deriving (Eq, Show)

updateModel act m = case act of
  Start -> noEff Off
  Print -> m <# do
    CurrDir . head <$> listDirectory "/Users/ocramz/Dropbox/RESEARCH/Haskell/miso-example"
  CurrDir t -> noEff $ On t

viewModel m = case m of
  Off -> div_ [] [button_ [onClick Print] [text "Current dir"]]
  On t -> div_ [] [
      text (ms t)
    , button_ [onClick Start] [text "Reset"]
                  ]
  

main = startApp App{..} where
  model = On "X"
  initialAction = Start
  update = updateModel
  view = viewModel
  events = defaultEvents
  mountPoint = Nothing
  subs = []
