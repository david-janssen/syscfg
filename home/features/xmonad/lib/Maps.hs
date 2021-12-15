module Maps where

import           XMonad
import           XMonad.Actions.CycleWS         ( nextScreen
                                                , shiftNextScreen
                                                )
import           XMonad.Layout.ResizableTile    ( MirrorResize(..) )
import           XMonad.Util.EZConfig           ( mkKeymap )

import qualified Data.Map                      as M
import qualified XMonad.StackSet               as W

import           Cmds
import           Polybar
import           Scratchpads                    ( scratch )

keyMap :: XConfig l -> M.Map (ButtonMask, KeySym) (X ())
keyMap cfg =
  mkKeymap cfg
    $  [
    -- Application launchers
         ("M-a"                      , spawn cmdEditor)
       , ("M-S-a"                    , spawn "emacs")  -- The non-client version
       , ("M-h"                      , spawn "org-capture")
       , ("M-r"                      , spawn cmdBrowser)
       , ("M-C-r"                    , scratch "browse")
       , ("M-s"                      , spawn cmdTerm)
       , ("M-t"                      , spawn cmdLauncher)
       , ("M-<Tab>"                  , spawn "rofi-pass")
       , ("M-d"                      , kill)

    -- Window moving and resizing
       , ("M-q"                      , sendMessage Shrink)
       , ("M-S-q"                    , sendMessage MirrorExpand)
       , ("M-w"                      , sendMessage Expand)
       , ("M-S-w"                    , sendMessage MirrorShrink)
       , ("M-f"                      , windows W.focusUp)
       , ("M-S-f"                    , windows W.swapUp)
       , ("M-p"                      , windows W.focusDown)
       , ("M-S-p"                    , windows W.swapDown)
       , ("M-g"                      , windows W.focusMaster)
       , ("M-S-g"                    , windows W.swapMaster)
       , ("M-v"                      , showBar)
       , ("M-S-v"                    , hideBar)

    -- Layout management
       , ("M-b"                      , sendMessage NextLayout)

    -- Named scratchpads
       , ("M-o"                      , scratch "cterm")
       , ("M-C-n"                    , scratch "lterm")
       , ("M-C-,"                    , scratch "bterm")
       , ("M-C-i"                    , scratch "rterm")
       , ("M-C-u"                    , scratch "tterm")
       , ("M-C-e"                    , scratch "fterm")
       , ("M-C-j"                    , scratch "kmonad")


    -- Working with a secondary monitor
       , ("M-z"                      , nextScreen)
       , ("M-S-z"                    , shiftNextScreen)

    -- Multimedia keys
       , ("<XF86AudioRaiseVolume>", spawn "pactl -- set-sink-volume 0 +10%")
       , ("<XF86AudioLowerVolume>", spawn "pactl -- set-sink-volume 0 -10%")
       , ("<XF86AudioMute>", spawn "pactl -- set-sink-mute   0 toggle")
       , ("<XF86MonBrightnessUp>"    , spawn "sudo light -A 10")
       , ("S-<XF86MonBrightnessUp>"  , spawn "sudo light -S 100")
       , ("<XF86MonBrightnessDown>"  , spawn "sudo light -U 10")
       , ("S-<XF86MonBrightnessDown>", spawn "sudo light -S 0")
       , ("M-<U>"                    , spawn "sudo light -A 10")
       , ("M-S-<U>"                  , spawn "sudo light -S 100")
       , ("M-<D>"                    , spawn "sudo light -U 10")
       , ("M-S-<D>"                  , spawn "sudo light -S 0")
       , ("M-<R>", spawn "pactl -- set-sink-volume 0 +10%")
       , ("M-<L>", spawn "pactl -- set-sink-volume 0 -10%")
       ]
    ++ spcKeys

 where
  mkSpcKey (k, w) =
    [("M-" ++ k, windows $ W.greedyView w), ("M-S-" ++ k, windows $ W.shift w)]
  spcKeys :: [(String, X ())]
  spcKeys = concatMap mkSpcKey
    $ zip ["m", ",", ".", "n", "e", "i", "l", "u", "y"] (workspaces cfg)

mouseMap (XConfig { XMonad.modMask = modm }) =
  M.fromList
    $ [ ( (modm, button1)
        , (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)
        )
      , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
      , ( (modm, button3)
        , (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)
        )
      ]
