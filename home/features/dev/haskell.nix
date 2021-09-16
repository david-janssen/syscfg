{ config, lib, pkgs, ... }:

{
  # Project-independent haskell tools
  home.packages = with pkgs.haskellPackages; [
    brittany                # code formatter
    cabal2nix               # convert cabal projects to nix
    cabal-install           # the `cabal` utility
    # ghc                     # haskell compiler
    # haskell-language-server # haskell IDE
    # hoogle                  # documentation
    # nix-tree                # visualize nix dependencies
  ];
}
