# NOTE: Autorandr has been disabled for now, can't get it to play nice with my
# 3-monitor setup. Switched to some simple shell aliases.
{ ... }:

let
  dsk = "xrandr --output DP-5 --mode 1920x1080 --primary --output DP-1 --mode 1920x1080 --left-of DP-5 --output HDMI-0 --mode 1920x1080 --right-of DP-5";
  fcs = "xrandr --output DP-5 --mode 1920x1080 --primary --output DP-1 --off --output HDMI-0 --off";
  cin = "xrandr --output DP-5 --off --output DP-1 --off --output HDMI-0 --mode 1920x1080 --primary";
  r2  = "xrandr --output DP-5 --mode 1920x1080 --primary --output DP-1 --off --output HDMI-0 --mode 1920x1080 --right-of DP-5";
  l2  = "xrandr --output DP-5 --mode 1920x1080 --primary --output DP-1 --mode 1920x1080 --left-of DP-5 --output HDMI-0 --off";
in
{
  programs.fish.shellAliases = {
    desk-view   = dsk;
    focus-view  = fcs;
    cinema-view = cin;
    r2-view     = r2;
    l2-view     = l2;
  };
}
