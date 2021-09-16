{ config, lib, pkgs, ... }:

{
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "${config.xdg.userDirs.documents}/secrets/passwords";
      PASSWORD_STORE_CLIP_TIME = "60";
    };
  };
}
