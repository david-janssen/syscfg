{ config, pkgs, ... }:

let
  gitConfig = {
    core.editor = "emacs";
    pull.rebase = false;
    url = {
      "https://github.com/".insteadOf = "gh:";
      "https://github.com/kmonad/kmonad".insteadOf = "km:";
      "https://github.com/david-janssen/syscfg".insteadOf = "sys:";
      "https://github.com/david-janssen/doomcfg".insteadOf = "doom:";
    };
    init.defaultBranch = "master";
    user.signingKey = "A09D71C32FA183F041565824C8464502A0DCC5F2!";
    commit.gpgSign = true;
    credential.helper = "store";
  };
in
{
  home.packages = [ pkgs.git-crypt ];

  programs.git = {
    enable = true;
    extraConfig = gitConfig;
    ignores = [
      "*.direnv"
      "*.envrc"
      "*hie.yaml"
    ];
    userEmail = "janssen.dhj@gmail.com";
    userName  = "David Janssen";
  };
}
