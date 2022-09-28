{ config, pkgs, this, ... }:
{
  imports = [
    # Packages that depend on `this`
    (import ./fish               { inherit config pkgs this; })
    (import ./networkmanager     { inherit config pkgs this; })
    (import ./rofi               { inherit config pkgs this; })
    # (import ./term-emu/urxvt.nix { inherit config pkgs this; })
    (import ./term-emu/kitty.nix { inherit config pkgs this; })

    # Packages that are uniform across machines
    ./browser/chromium.nix
    ./dconf
    ./emacs
    ./git
    ./password-store
  ];
}
