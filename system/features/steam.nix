{ config, lib, pkgs, ... }:

{
  programs.steam.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

    # with pkgs; [ gamemode ];
}
