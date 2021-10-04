{-# OPTIONS_GHC -fno-warn-missing-signatures #-}


-- Imports ---------------------------------------------------------------------
import           XMonad

import           XMonad.Hooks.ManageDocks       ( avoidStruts
                                                , docks
                                                )
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Layout.NoBorders
import           XMonad.Layout.ResizableTile
import           XMonad.Layout.Spacing

import           Cmds                           ( cmdTerm )
import           Maps                           ( keyMap
                                                , mouseMap
                                                )
import           Polybar                        ( dockManage
                                                , polyLog
                                                )
import           Scratchpads                    ( scratchManage )
import           Theme                          ( getColor
                                                , loadTheme
                                                )

import qualified XMonad.StackSet               as W

-- Main config ----------------------------------------------------------------

djConfig = do
  theme <- loadTheme
  plLog <- polyLog theme
  pure $ def { borderWidth        = 2
             , normalBorderColor  = getColor "base0" theme
             , focusedBorderColor = getColor "selection" theme
             , modMask            = mod4Mask
             , terminal           = cmdTerm
             , focusFollowsMouse  = False
             , clickJustFocuses   = False
             , keys               = keyMap
             , mouseBindings      = mouseMap
             , workspaces         = map show [1 .. 9]
             , layoutHook         = djLayout
             , logHook            = plLog
             , manageHook         = djManageHook
             , startupHook        = def
             }

main :: IO ()
main = djConfig >>= \cfg -> xmonad . ewmh $ docks $ cfg

djLayout = tiled ||| spaced tiled ||| noBorders Full
 where
  tiled  = smartBorders . avoidStruts $ ResizableTall 1 (3 / 100) (1 / 2) []
  spaced = spacingRaw False (b 0) True (b 20) True
  b x = (Border x x x x)

djManageHook =
  composeAll [ isDialog --> doCenterFloat
             , dockManage
             , scratchManage
             , appName =? "Steam" --> doFloat
             ]
