{ config, lib, pkgs, ... }:

let
  extraPkgs = p: [
    # Required for vterm
    p.vterm
  ];
in
{
  # Extra packages for the system
  home.packages = with pkgs; [
    # Spell-checking with doom's spell-check module
    (aspellWithDicts (ds: with ds; [ en nl es ]))

    # For use with emacs-everywhere
    # xdotool
    # xorg.xwininfo
  ];

  # Emacs-overlay to access emacs28
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
     url = https://github.com/nix-community/emacs-overlay/archive/2264d27fe9048a982411fda879ed638119f5cbbc.tar.gz;
    }))
  ];

  # Install emacs with vterm support
  programs.emacs = {
    enable = true;
    package = pkgs.emacsGit;

    extraPackages = extraPkgs;
    # extraConfig = "(defvar testyboop 3)"; Not yet supported in 21.05
  };

  # Run an emacsdaemon in the background
  services.emacs.enable = false;
}
