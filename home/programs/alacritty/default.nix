{ this, pkgs, ... }:

let theme = this.theme; in

{
  programs.alacritty = {

    enable = true;

    settings = {

      background_opacity = 1;

      colors = {
        primary = {
          background = "#${theme.bg}";
          foreground = "#${theme.fg}";
        };
      };

      font = {
        normal = {
          family = "Mononoki Nerd Font";
          style  = "Regular";
        };
      };

      selection.save_to_clipboard = true;
      shell.program = "${pkgs.fish}/bin/fish";

      window = {
        decorations = "none";
        padding = {
          x = 0;
          y = 0;
        };
      };
    };
  };
}
