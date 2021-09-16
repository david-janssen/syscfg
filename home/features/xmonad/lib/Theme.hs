module Theme where

import           Data.Maybe                     ( fromJust )
import           Text.JSON
import           Text.JSON.String

-- | Colors are encoded as '#rrggbb' hex-values
type Color = String

-- | Themes are simple alists of name to color mappings
type Theme = [(String, Color)]

-- | Try to read an entry from a theme, return bright red on failure
getColor :: String -> Theme -> Color
getColor n = maybe "#ff0000" ('#' :) . lookup n

-- | FIXME this doesn't work
logMsg :: String -> IO ()
logMsg = appendFile "/tmp/xmonad-log"

-- | Load the current theme from 'theme.json'
loadTheme :: IO [(String, String)]
loadTheme = do
  raw <- readFile "/home/david/.xmonad/lib/theme.json"
  case runGetJSON readJSObject raw of
    Left  e -> (logMsg $ "Error parsing JSON object: " <> e) >> pure []
    Right a -> case decJSDict "theme" a of
      Error e -> logMsg ("Error turning object into list: " <> e) >> pure []
      Ok    w -> pure w
