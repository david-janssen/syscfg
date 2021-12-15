module Cmds where

-- | A command is a String used to launch some program
type Cmd = String


cmdEditor, cmdLauncher, cmdBrowser, cmdTerm :: Cmd
-- cmdEditor   = "emacsclient -c"
cmdEditor   = "emacs"
cmdLauncher = "rofi -modi drun,ssh,window -show drun -show-icons -monitor primary"
cmdBrowser  = "chromium"
cmdTerm     = "alacritty"


-- captureCmd = "emacsclient -nc -F " ++ traits ++ " --eval " ++ cmd ++ " &>/tmp/err"
--   where
--     name   = show $ "capture"
--     traits = show $ "(quote (name . " ++ name ++ "))"
--     cmd    = show $ "(make-capture-frame)"
