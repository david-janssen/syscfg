{ this, config, pkgs, ... }:

let theme = this.theme; in

# Trying kitty, since alacritty has glx problems
# ... trying it now... very nice

{
  programs.kitty = {
    enable = false; # true; can't run 'switch', bug in kitty.nix
    theme = "#${theme.kitty-theme}";
    settings = {
      scrollback_lines = 10000;
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      foreground = "#${theme.fg}";
      background = "#${theme.bg}";
    };
  };
}
