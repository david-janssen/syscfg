{ config, lib, pkgs, ... }:

let
  fp = {
    DP-1     = "00ffffffffffff0005e30227ec000000201e0103803c22782a81b5a4554d99260d5054bfef00d1c0b30095008180814081c001010101023a801871382d40582c450056502100001e2a4480a0703827403020350056502100001a000000fc00323742320a2020202020202020000000fd00304b1e5512000a202020202020018702031ef14b101f051404130312021101230907078301000065030c001000023a801871382d40582c450056502100001e011d007251d01e206e28550056502100001e8c0ad08a20e02d10103e96005650210000188c0ad090204031200c4055005650210000180000000000000000000000000000000000000000000000000069";
    HDMI-0   = "00ffffffffffff0005e3022798a00100201e0103803c22782a81b5a4554d99260d5054bfef00d1c0b30095008180814081c001010101023a801871382d40582c450056502100001e2a4480a0703827403020350056502100001a000000fc00323742320a2020202020202020000000fd00304b1e5512000a202020202020013a02031ef14b101f051404130312021101230907078301000065030c001000023a801871382d40582c450056502100001e011d007251d01e206e28550056502100001e8c0ad08a20e02d10103e96005650210000188c0ad090204031200c4055005650210000180000000000000000000000000000000000000000000000000069I";
  };

  dp1 = {
    crtc     = 1;
    enable   = true;
    mode     = "1920x1080";
    position = "0x0";
    rate     = "60.00";
  };

  hdmi0 = {
    crtc     = 0;
    enable   = true;
    position = "1920x0";
    primary  = true;
    mode     = "1920x1080";
    rate     = "60.00";
  };

in
{
  programs.autorandr = {

    enable = true;

    profiles = rec {

      "default" = desk;

      "desk" = {
        fingerprint = fp;
        config = {
          DP-1   = dp1;
          HDMI-0 = hdmi0;
        };
        hooks.postswitch = "systemctl --user start gammastep.service";
      };

      "focus" = {
        fingerprint = fp;
        config = {
          DP-1.enable = false;
          HDMI-0 = hdmi0 // { position = "0x0";};
        };
        hooks.postswitch = "systemctl --user start gammastep.service";
      };

      "floor" = {
        fingerprint = fp;
        config = {
          DP-1   = dp1 // { primary = true; };
          HDMI-0.enable = false;
        };
        hooks.postswitch = "systemctl --user start gammastep.service";
      };

      "dark-floor" = {
        fingerprint = fp;

        config = {
          DP-1 = dp1 // { primary = true; };
          HDMI-0.enable = false;
        };

        hooks = {
          preswitch = "systemctl --user stop gammastep.service";
          postswitch = "xrandr --output DP-1 --gamma 1.0:.64:0.28 --brightness 0.1";
        };
      };
    };
  };
}
