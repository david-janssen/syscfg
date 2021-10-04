-- |

module Scratchpads
  ( scratch
  , scratchManage
  ) where

import           XMonad
import           XMonad.Util.NamedScratchpad

import qualified XMonad.StackSet               as W

import           Cmds

h = (1 / 2)

cF = customFloating $ W.RationalRect (1 / 6) (1 / 6) (2 / 3) (2 / 3)
lF = customFloating $ W.RationalRect 0 0 h 1
bF = customFloating $ W.RationalRect 0 h 1 h
rF = customFloating $ W.RationalRect h 0 h 1
tF = customFloating $ W.RationalRect 0 0 1 h

scratchpads =
  [ -- 5 floating terms
    NS "cterm"  (cmdTerm ++ " -t cterm")  (title =? "cterm")  cF
  , NS "lterm"  (cmdTerm ++ " -t lterm")  (title =? "lterm")  lF
  , NS "bterm"  (cmdTerm ++ " -t bterm")  (title =? "bterm")  bF
  , NS "rterm"  (cmdTerm ++ " -t rterm")  (title =? "rterm")  rF
  , NS "tterm"  (cmdTerm ++ " -t tterm")  (title =? "tterm")  tF

    -- A term specifically for running kmonad
  , NS "kmonad" (cmdTerm ++ "  -t kmonad") (title =? "kmonad") cF
  ]

scratch :: String -> X ()
scratch = namedScratchpadAction scratchpads

scratchManage :: ManageHook
scratchManage = namedScratchpadManageHook scratchpads
