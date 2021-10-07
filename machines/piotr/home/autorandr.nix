{ config, lib, pkgs, ... }:

let

  # Fingerprints ---------------------------------------------------------------

  laptop = "00ffffffffffff0006af3c310000000000140103801f11780a10b597585792261e505400000001010101010101010101010101010101121b5646500023302616360035ad100000180000000f0000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231343058544e30332e31200a0026";
  lg_mon = "00ffffffffffff001e6d555b01010101011a010380301b78ea3135a5554ea1260c5054a54b00714f81809500b300a9c0810081c09040023a801871382d40582c4500e00e1100001e000000fd00384b1e5512000a202020202020000000fc004c472046554c4c2048440a2020000000ff000a202020202020202020202020016102031bf14890040301121f1013230907078301000065030c001000023a801871382d40582c4500e00e1100001e2a4480a07038274030203500e00e1100001e011d007251d01e206e285500e00e1100001e8c0ad08a20e02d10103e9600e00e11000018000000000000000000000000000000000000000000000000000000004b";

  solo = { LVDS-1 = laptop; };
  both = solo // { HDMI-1 = lg_mon; };

  # Default configs ------------------------------------------------------------

  lvds-1 = {
    crtc     = 0;
    enable   = true;
    position = "0x0";
    primary  = false;
    mode     = "1366x768";
    rate     = "60.00";
  };

  hdmi-1 = {
    crtc     = 1;
    enable   = true;
    mode     = "1920x1080";
    position = "1366x0";
    primary  = true;
    rate     = "60.00";
  };

  # Theming --------------------------------------------------------------------
  wallpaper = (import ../this.nix).theme.wallpaper;
  bg-cmd    = "feh --bg-scale ${wallpaper}";

in
{
  programs.autorandr = {

    enable = true;

    profiles = rec {

      "default" = desk;

      "mobile" = {
        fingerprint = solo;
        config = { LVDS-1 = lvds-1 // { primary = true; }; };
        hooks.postswitch = bg-cmd;
      };

      "desk" = {
        fingerprint = both;
        config = { LVDS-1 = lvds-1; HDMI-1 = hdmi-1; };
        hooks.postswitch = bg-cmd;
      };

      "cinema" = {
        fingerprint = both;
        config = {
          LVDS-1 = lvds-1 // { enable = false; };
          HDMI-1 = hdmi-1 // { position = "0x0"; };
        };
        hooks.postswitch = bg-cmd;
      };
    };
  };
}
