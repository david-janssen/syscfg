{ pkgs, ... }:

{
  services = {
     # Required to interact with polybar
    dbus = {
      enable   = true;
      packages = [ pkgs.gnome.dconf ];
    };

    # Enable xmonad with contribs
    xserver.windowManager.xmonad = {
      enable                 = true;
      enableContribAndExtras = true;
    };
  };
}
