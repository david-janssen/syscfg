module Maps where

import           XMonad
import           XMonad.Actions.CycleWS         ( nextScreen
                                                , shiftNextScreen
                                                )
import           XMonad.Actions.PhysicalScreens
import           XMonad.Actions.OnScreen
import           XMonad.Layout.ResizableTile    ( MirrorResize(..) )
import           XMonad.Util.EZConfig           ( mkKeymap )

import qualified Data.Map                      as M
import qualified XMonad.StackSet               as W

import           Cmds
import           Polybar
import           Scratchpads                    ( scratch )

fixMods = spawn "xmodmap /home/david/.config/nixpkgs/features/xmonad/xmodmap"

-- | Move workspace name 'w' to appear on screen 's' (counting from the left)
viewOn :: PhysicalScreen -> String -> X ()
viewOn s w = do
  s' <- getScreen def s
  case s' of
    Nothing -> pure ()
    Just s' -> windows $ onlyOnScreen s' w


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
       , ("M-k"                      , fixMods)
       , ("M4-o"                      , scratch "cterm")
       , ("M4-C-o"                    , scratch "lterm")
       , ("M2-o"                     , scratch "rterm")
       , ("M3-o"                     , scratch "bterm")
       , ("M5-o"                     , scratch "tterm")

       -- , ("M-C-u"                    , scratch "tterm")
       -- , ("M-C-e"                    , scratch "fterm")
       -- , ("M-C-j"                    , scratch "kmonad")


    -- Working with a secondary monitor
       -- , ("M-z"                      , nextScreen)
       -- , ("M-S-z"                    , shiftNextScreen)

       , ("M-M2-m"                   , viewOn 0 "1")
       , ("M-M2-,"                   , viewOn 0 "2")
       , ("M-M2-."                   , viewOn 0 "3")
       , ("M-M2-n"                   , viewOn 0 "4")
       , ("M-M2-e"                   , viewOn 0 "5")
       , ("M-M2-i"                   , viewOn 0 "6")
       , ("M-M2-l"                   , viewOn 0 "7")
       , ("M-M2-u"                   , viewOn 0 "8")
       , ("M-M2-y"                   , viewOn 0 "9")

       , ("M-M3-m"                   , viewOn 1 "1")
       , ("M-M3-,"                   , viewOn 1 "2")
       , ("M-M3-."                   , viewOn 1 "3")
       , ("M-M3-n"                   , viewOn 1 "4")
       , ("M-M3-e"                   , viewOn 1 "5")
       , ("M-M3-i"                   , viewOn 1 "6")
       , ("M-M3-l"                   , viewOn 1 "7")
       , ("M-M3-u"                   , viewOn 1 "8")
       , ("M-M3-y"                   , viewOn 1 "9")

       , ("M-M5-m"                   , viewOn 2 "1")
       , ("M-M5-,"                   , viewOn 2 "2")
       , ("M-M5-."                   , viewOn 2 "3")
       , ("M-M5-n"                   , viewOn 2 "4")
       , ("M-M5-e"                   , viewOn 2 "5")
       , ("M-M5-i"                   , viewOn 2 "6")
       , ("M-M5-l"                   , viewOn 2 "7")
       , ("M-M5-u"                   , viewOn 2 "8")
       , ("M-M5-y"                   , viewOn 2 "9")

       , ("M-M2-<Home>"              , viewScreen def 0)
       , ("M-M3-<Home>"              , viewScreen def 1)
       , ("M-M5-<Home>"              , viewScreen def 2)

       , ("M-M2-S-<Home>"            , sendToScreen def 0)
       , ("M-M3-S-<Home>"            , sendToScreen def 1)
       , ("M-M5-S-<Home>"            , sendToScreen def 2)


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
