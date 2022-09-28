{ config, pkgs, ... }:

let
  gitConfig = {
    checkout.defaultRemote = "origin";
    commit.gpgSign = false; # true; Doesn't work out of the box on pete
    core.editor = "emacs";
    credential.helper = "store";
    init.defaultBranch = "master";
    github.user = "david-janssen";
    pull.rebase = false;
    url = {
      "https://github.com/".insteadOf = "gh:";
      "https://github.com/david-janssen/".insteadOf = "dj:";
      "https://github.com/kmonad/kmonad".insteadOf = "km:";
      "https://github.com/david-janssen/syscfg".insteadOf = "sys:";
      "https://github.com/david-janssen/doomcfg".insteadOf = "doom:";
    };
    user.signingKey = "A09D71C32FA183F041565824C8464502A0DCC5F2!";
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
      "/notes.org"
    ];
    userEmail = "janssen.dhj@gmail.com";
    userName  = "David Janssen";
  };
}
