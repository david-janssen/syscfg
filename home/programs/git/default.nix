{ config, pkgs, ... }:

let
  gitConfig = {
    core = {
      editor = "emacs";
    };
    pull.rebase = false;
    url = {
      "https://github.com/".insteadOf = "gh:";
    };
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
