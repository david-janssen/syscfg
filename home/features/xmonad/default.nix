{ this, pkgs, ... }:

let

  theme = this.theme;

  startup = ''
    feh --bg-scale ${this.theme.wallpaper} &
    pasystray &
    autorandr -c default &
    '' + (if this.isLaptop
          then ''nm-applet --sm-disable --indicator &''
          else "");
in
{
  home.packages = with pkgs; [
    networkmanager_dmenu    # networkmanager via dmenu
    networkmanagerapplet    # systray applet
  ];

  xresources.properties = {
    "Xft.dpi"       = 96;
    "Xft.autohint"  = 0;
    "Xft.hintstyle" = "hintfull";
    "Xft.hinting"   = 1;
    "Xft.antialias" = 1;
    "Xft.rgba"      = "rgb";
    "Xcursor*theme" = "Vanilla-DMZ-AA";
    "Xcursor*size"  = 24;
  };

  xsession = {
    enable = true;

    initExtra = startup;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp: [
        hp.dbus
        hp.json
        hp.monad-logger
        hp.text
      ];

      config = ./config.hs;

      libFiles = {
        "Cmds.hs"        = ./lib/Cmds.hs;
        "Maps.hs"        = ./lib/Maps.hs;
        "Polybar.hs"     = ./lib/Polybar.hs;
        "Scratchpads.hs" = ./lib/Scratchpads.hs;
        "Theme.hs"       = ./lib/Theme.hs;
        "theme.json"     = pkgs.writeText "theme.json" (builtins.toJSON theme);
      };
    };
  };
}
