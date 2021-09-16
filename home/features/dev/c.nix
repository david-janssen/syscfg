{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    cmake   # Make file generator
    gnumake # Make file executor
    gcc     # C compiler
  ];
}
