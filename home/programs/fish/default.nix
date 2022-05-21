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

  extraInit = ''
    set -p fish_function_path ${builtins.toString ./functions}

  '';
in

{
  programs.fish = {
    enable = true;
    plugins = [ theme-plugin ];
    interactiveShellInit = ''
      eval (direnv hook fish)
      any-nix-shell fish --info-right | source
    '';
    shellAliases = {
      cat     = "bat";
      du      = "ncdu --color dark -rr -x";
      ".."    = "cd ..";
      ping    = "prettyping";
      mkhome  = "mksys home";
      pp      = "cd (git rev-parse --show-toplevel)";

      encrypt = "gpg --encrypt -r janssen.dhj@gmail.com";
      decrypt = "gpg --decrypt";

      # HACK: At some point I should integrate kmonad into nixpkgs and
      # home-manager, but first we make it work.
      #
      kma = "sudo kmonad ~/.config/kmonad/atreus.kbd -l debug";
      xmd = "xmodmap ~/.config/nixpkgs/assets/xmodmap";

      # Make standard ls command use exa
      ls = "${pkgs.exa}/bin/exa --group-directories-first";
      lt = "${pkgs.exa}/bin/exa --group-directories-first --tree";
      la = "${pkgs.exa}/bin/exa --group-directories-first -l";
      ll = "${pkgs.exa}/bin/exa --group-directories-first -a";

    };
    shellInit = themeInit + extraInit;
    functions = {
      fish_greeting = "";
      pc = {
        wraps = "pass -c";
        body = "pass -c $argv[1]";
      };
      reload = "source ~/.config/fish/config.fish";
      book = {
        description = "Open a book from documents and disown zathura";
        body = ''
          find ~/dcs/books -type f | fzf > /tmp/book_file
          cat /tmp/book_file | xargs -I % nohup zathura % > /dev/null 2>&1 &
          disown
        '';
      };
      nix-def = {
        description = "Open a nix-shell for a local package";
        body = ''
          if not set -q argv[1]
              set argv[1] ./default.nix
          end

          nix-shell -E "with import <nixpkgs> {}; callPackage $argv[1] {}"
        '';
      };
    };
  };
}
