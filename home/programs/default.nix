{ config, pkgs, this, ... }:
{
  imports = [
    # Packages that depend on `this`
    (import ./alacritty      { inherit config pkgs this; })
    (import ./fish           { inherit config pkgs this; })
    (import ./networkmanager { inherit config pkgs this; })
    (import ./rofi           { inherit config pkgs this; })

    # Packages that are uniform across machines
    ./browser/chromium.nix
    ./dconf
    ./emacs
    ./git
    ./password-store
  ];
}
