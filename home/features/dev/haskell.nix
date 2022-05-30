{ config, lib, pkgs, ... }:

{
  # The packages I need access to before I can access project-specific nix
  # specifications.
  home.packages = with pkgs.haskellPackages; [
      niv        # Not haskell specific, but I only use if for haskell-dev
      cabal2nix  # Used to create `default.nix` used in my `shell.nix` files
      dhall      # Better cfgs
      dhall-json # To experiments
      zlib
  ];
}
