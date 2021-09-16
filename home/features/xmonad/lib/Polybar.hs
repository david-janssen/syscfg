-- | Configuration for polybar

module Polybar
  ( polyLog
  , showBar
  , hideBar
  , dockManage
  ) where

import           XMonad
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks

import qualified Codec.Binary.UTF8.String      as UTF8
import qualified DBus                          as D
import qualified DBus.Client                   as D

import           Theme

-- | Initialize a DBus client, and register a name
dbusInit :: IO D.Client
dbusInit = do
  let opts = [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]
  d <- D.connectSession
  D.requestName d (D.busName_ "org.xmonad.Log") opts
  pure d

-- | Send a message to a DBus session
dbusLog :: D.Client -> String -> IO ()
dbusLog d s =
  let opath  = D.objectPath_ "/org/xmonad/Log"
      iname  = D.interfaceName_ "org.xmonad.Log"
      mname  = D.memberName_ "Update"
      signal = D.signal opath iname mname
      body   = [D.toVariant $ UTF8.decodeString s]
  in  D.emit d $ signal { D.signalBody = body }

-- | Pretty-print the window layout
dbusHook :: Theme -> D.Client -> PP
dbusHook t d =
  let color c s | s /= "NSP" = wrap ("%{F" <> getColor c t <> "}") "%{F-}" s
                | otherwise  = mempty
      lsymb l = case l of
        "ResizableTall"         -> ">>>"
        "Spacing ResizableTall" -> "> >"
        "Full"                  -> "< >"
        _                       -> l
  in  def { ppOutput          = dbusLog d
          , ppCurrent         = color "function"
          , ppVisible         = color "keyword"
          , ppHidden          = color "comment"
          , ppHiddenNoWindows = const " "
          , ppOrder           = \(w : l : t : _) -> [l, w, t]
          , ppWsSep           = ""
          , ppSep             = " "
          , ppTitle           = color "string" . shorten 50
          , ppLayout          = color "type" . lsymb
          }

-- | Loghook that writes the window-layout to a dbus socket in a polybar format
polyLog :: Theme -> IO (X ())
polyLog t = do
  d <- dbusInit
  pure $ dynamicLogWithPP (dbusHook t d)

-- | Actions to show and hide the bar
showBar, hideBar :: X ()
showBar = do
  spawn "polybar-msg cmd show"
  sendMessage $ SetStruts [minBound .. maxBound] []
hideBar = do
  spawn "polybar-msg cmd hide"
  sendMessage $ SetStruts [] [minBound .. maxBound]

dockManage :: ManageHook
dockManage = manageDocks
