{ config, pkgs, ... }:

{
  programs.urxvt =
    { enable = true;
      scroll.bar.enable = false;
      # fonts = [ "xft:Mononoki Nerd Font:style=Medium:size=12;3" ];

    };
}
