{
  imports = [
  ];

  programs.fish.shellAliases = {
    small     = "xrandr --output LVDS-1 --auto --output HDMI-1 --off";
    big       = "xrandr --output LVDS-1 --off --output HDMI-1 --auto";
    small-big = "xrandr --output LVDS-1 --auto --output HDMI-1 --auto --right-of LVDS-1 --primary";
    big-small = "xrandr --output LVDS-1 --auto --output HDMI-1 --auto --left-of LVDS-1 --primary";
  };

  home.stateVersion = "21.05";
}
