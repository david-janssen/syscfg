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

fF = customFloating $ W.RationalRect 0 0 1 1
cF = customFloating $ W.RationalRect (1 / 6) (1 / 6) (2 / 3) (2 / 3)
lF = customFloating $ W.RationalRect 0 0 h 1
bF = customFloating $ W.RationalRect 0 h 1 h
rF = customFloating $ W.RationalRect h 0 h 1
tF = customFloating $ W.RationalRect 0 0 1 h

scratchpads =
  [ -- small center float
    NS "cterm"  (cmdTerm ++ " -T cterm")  (title =? "cterm")  cF

    -- 4 floating terms in the different screen-halves
  , NS "lterm"  (cmdTerm ++ " -T lterm") (title =? "lterm")  lF
  , NS "bterm"  (cmdTerm ++ " -T bterm") (title =? "bterm")  bF
  , NS "rterm"  (cmdTerm ++ " -T rterm") (title =? "rterm")  rF
  , NS "tterm"  (cmdTerm ++ " -T tterm") (title =? "tterm")  tF

    -- big fullscreen term
  , NS "fterm"  (cmdTerm ++ " -T fterm") (title =? "fterm") fF

    -- A term specifically for running kmonad
  , NS "kmonad" (cmdTerm ++ "  -T kmonad") (title =? "kmonad") rF
  ]

scratch :: String -> X ()
scratch = namedScratchpadAction scratchpads

scratchManage :: ManageHook
scratchManage = namedScratchpadManageHook scratchpads
