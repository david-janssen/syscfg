{ config, pkgs, this, ... }:
let
  pb = import ./polybar { inherit this config pkgs; };
in
{
  imports = [
    ./dunst
    ./gpg-agent
    pb
    ./udiskie
  ];
}
