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
    # For use with emacs-everywhere
    xdotool
    xorg.xwininfo
  ];

  # Emacs-overlay to access emacs28
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/de00abcd9631b104ef2868e1e0a877b1ec6b5633.tar.gz;
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
  services.emacs.enable = true;
}
