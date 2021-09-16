{ this, config, pkgs, ... }:

let

  t = this.theme;

  theme-plugin =
    { name = "bobthefish";
      src = pkgs.fetchFromGitHub {
        owner  = "oh-my-fish";
        repo   = "theme-bobthefish";
        rev    = "626bd39b002535d69e56adba5b58a1060cfb6d7b";
        sha256 = "06whihwk7cpyi3bxvvh3qqbd5560rknm88psrajvj7308slf0jfd";
      };
    };

  # Configuration settings on the fish builtin colors
  colorCfg = ''
    set fish_color_command        ${t.function} # Color of first command in line
    set fish_color_autosuggestion ${t.comment}  # Autocompletion and prompt
    set fish_color_operator       ${t.constant} # $references
    set fish_color_param          ${t.variable} # Arguments to commands
    '';

  # Configuration settings on the bob-the-fish theme
  promptCfg = ''
    set -g theme_display_date no
    set -g theme_display_nix yes
    set -g theme_nerd_fonts yes
    set -g theme_newline_cursor yes
    set -g theme_newline_prompt '→ '
    set -g theme_display_git_master_branch no

    function bobthefish_colors -S -d 'Define a custom bobthefish color scheme'

      # optionally include a base color scheme...
      __bobthefish_colors default

      set -x color_initial_segment_exit     ${t.base3}  ${t.red}   --bold
      set -x color_initial_segment_private  ${t.base3}  ${t.blue}
      set -x color_initial_segment_su       ${t.base3}  ${t.green} --bold
      set -x color_initial_segment_jobs     ${t.base3}  ${t.cyan}  --bold

      set -x color_path                     ${t.base4}  ${t.base7}
      set -x color_path_basename            ${t.base4}  ${t.base7} --bold
      set -x color_path_nowrite             ${t.red}    ${t.base7}
      set -x color_path_nowrite_basename    ${t.red}    ${t.base7} --bold

      set -x color_repo                     ${t.green}  ${t.base0}
      set -x color_repo_work_tree           ${t.base3}  ${t.base0} --bold
      set -x color_repo_dirty               ${t.red}    ${t.base0}
      set -x color_repo_staged              ${t.yellow} ${t.base0}

      set -x color_nix                      ${t.blue}   ${t.base8} --bold
    end
    '';

  fishConfig = promptCfg + colorCfg;
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
      ar   = "autorandr -c";
      cat  = "bat";
      du   = "ncdu --color dark -rr -x";
      ".." = "cd ..";
      ping = "prettyping";
    };
    shellInit = fishConfig;
    functions = {
      fish_greeting = "";
    };
  };
}
