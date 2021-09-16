-- |

module Scratchpads
  ( scratch
  , scratchManage
  ) where

import           XMonad
import           XMonad.Util.NamedScratchpad

import qualified XMonad.StackSet               as W

import           Cmds


centerFloat = customFloating $ W.RationalRect (1 / 4) (1 / 4) (1 / 2) (1 / 2)
leftFloat = customFloating $ W.RationalRect 0 0 (1 / 2) 1

scratchpads =
  [ NS "term"   (cmdTerm ++ " -t term")   (title =? "term")   centerFloat
  , NS "kmonad" (cmdTerm ++ " -t kmonad") (title =? "kmonad") leftFloat
  ]

scratch :: String -> X ()
scratch = namedScratchpadAction scratchpads

scratchManage :: ManageHook
scratchManage = namedScratchpadManageHook scratchpads
