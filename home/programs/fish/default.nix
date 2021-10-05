{ this, config, pkgs, ... }:

let
  theme-plugin =
    { name = "bobthefish";
      src = pkgs.fetchFromGitHub {
        owner  = "oh-my-fish";
        repo   = "theme-bobthefish";
        rev    = "626bd39b002535d69e56adba5b58a1060cfb6d7b";
        sha256 = "06whihwk7cpyi3bxvvh3qqbd5560rknm88psrajvj7308slf0jfd";
      };
    };

  themeInit = import ./theme.nix { inherit this config pkgs; };
in

{
  programs.fish = {
    enable = true;
    plugins = [ theme-plugin ];
    promptInit = ''
      eval (direnv hook fish)
      any-nix-shell fish --info-right | source
    '';
    shellAliases = {
      ar     = "autorandr -c";
      cat    = "bat";
      du     = "ncdu --color dark -rr -x";
      ".."   = "cd ..";
      ping   = "prettyping";
      mkhome = "mksys home";
      # HACK: At some point I should integrate kmonad into nixpkgs and
      # home-manager, but first we make it work.
      kma    = "sudo kmonad ~/.config/kmonad/atreus.kbd -l debug";
    };
    shellInit = themeInit;
    functions = {
      fish_greeting = "";
      pc = {
        wraps = "pass -c";
        body = "pass -c $argv[1]";
      };
    };
  };
}
