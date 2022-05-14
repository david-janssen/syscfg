{ config, lib, pkgs, ... }:

let
  asus = "00ffffffffffff0006b3d227b9750200251f0103803c22782ae925a4554f9a260e5054bfef00d1c0b30095008180814081c0714f0101023a801871382d40582c450056502100001e000000ff004d394c4d54463136313230390a000000fd00304b185412000a202020202020000000fc004153555320564132374548450a01c602032b714f0102031112130414050e0f1d1e1f90230917078301000065030c001000681a00000101304be66842806a703827400820980456502100001a011d007251d01e206e28550056502100001e011d00bc52d01e20b828554056502100001e8c0ad090204031200c405500565021000018000000000000000000000000b7";
  aoc  = "00ffffffffffff0005e30227ec000000201e0103803c22782a81b5a4554d99260d5054bfef00d1c0b30095008180814081c001010101023a801871382d40582c450056502100001e2a4480a0703827403020350056502100001a000000fc00323742320a2020202020202020000000fd00304b1e5512000a202020202020018702031ef14b101f051404130312021101230907078301000065030c001000023a801871382d40582c450056502100001e011d007251d01e206e28550056502100001e8c0ad08a20e02d10103e96005650210000188c0ad090204031200c4055005650210000180000000000000000000000000000000000000000000000000069";
  fp = {
    DP-5   = asus; # center
    DP-1   = aoc;  # left
    HDMI-0 = aoc;  # right
  };

  fst = { position = "0x0";    crtc = 0; };
  snd = { position = "1920x0"; crtc = 1; };
  trd = { position = "3840x0"; crtc = 2; };

  pri = { primary = true; };
  off = { enable = false; };

  hdmi0 = {
    enable   = true;
    mode     = "1920x1080";
    rate     = "60.00";
  };

  dp1 = {
    enable   = true;
    mode     = "1920x1080";
    rate     = "60.00";
  };

  dp5 = {
    enable   = true;
    mode     = "1920x1080";
    rate     = "60.00";
  };

  dsk = "xrandr --output DP-5 --mode 1920x1080 --primary --output DP-1 --mode 1920x1080 --left-of DP-5 --output HDMI-0 --mode 1920x1080 --right-of DP-5";
  fcs = "xrandr --output DP-5 --mode 1920x1080 --primary --output DP-1 --off --output HDMI-0 --off";
  cin = "xrandr --output DP-5 --off --output DP-1 --off --output HDMI-0 --mode 1920x1080 --primary";

in
{
  # The simple way out
  programs.fish.shellAliases = {
    ar-desk   = dsk;
    ar-focus  = fcs;
    ar-cinema = cin;
  };

  programs.autorandr = {

    #enable = true; NOTE: disabled

    # autorandr doesn't want to work with my 3 monitor setup: it seems fine, but
    # when I switch into cinema *and then* into desk, it all gets weird. It
    # tries to be really clever with 'panning' and such, and screws stuff up.
    # Probably my fault, but I'd rather just take the simple way out.
    enable = false;

    profiles = rec {

      "default" = desk;

      "desk" = {
        fingerprint = fp;
        config = {
          DP-1   = dp1   // fst;
          DP-5   = dp5   // snd // pri;
          HDMI-0 = hdmi0 // trd;
        };
        hooks.postswitch = "systemctl --user start gammastep.service";
      };

      "focus" = {
        fingerprint = fp;
        config = {
          DP-1   = dp1   // off;
          DP-5   = dp5   // fst // pri;
          HDMI-0 = hdmi0 // off ;
        };
        hooks.postswitch = "systemctl --user start gammastep.service";
      };

      "cinema" = {
        fingerprint = fp;
        config = {
          DP-1   = dp1   // off;
          DP-5   = dp5   // off;
          HDMI-0 = hdmi0 // fst // pri;
        };
        hooks.postswitch = "systemctl --user start gammastep.service";
      };
    };
  };
}
