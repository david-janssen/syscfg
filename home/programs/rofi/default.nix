{ config, this, pkgs, ... }:

let
  theme = this.theme;
  inherit (config.lib.formats.rasi) mkLiteral;
in

{
  programs.rofi = {
    enable = true;
    font = "Mononoki Nerd Font 14";
    location = "center";
    pass.enable = true;
    # separator = "none";
    # scrollbar = false;
    terminal = "${pkgs.alacritty}/bin/alacritty";

    theme = {
      "*" = {
        background-color = mkLiteral "#${theme.base1}";
        foreground-color = mkLiteral "#${theme.fg}";
        border-color     = mkLiteral "#${theme.base4}";
      };
    };

    # }
    # colors = {
    #   window = {
    #     background = "#${theme.base1}";
    #     border     = "#${theme.base4}";
    #     separator  = "#${theme.red}";
    #   };

    #   rows = {

    #     # Color settings for the active row
    #     active = {
    #       background    = "#${theme.base2}";
    #       backgroundAlt = "#${theme.base3}";
    #       foreground    = "#${theme.fg}";
    #       highlight  = {
    #         background = "#${theme.base5}";
    #         foreground = "#${theme.fg}";
    #       };
    #     };

    #     # Color settings for the other rows
    #     normal = {
    #       background    = "#${theme.base2}";
    #       backgroundAlt = "#${theme.base3}";
    #       foreground    = "#${theme.fg}";
    #       highlight  = {
    #         background = "#${theme.base5}";
    #         foreground = "#${theme.fg}";
    #       };
    #     };

    #     # Color settings for the urgent rows
    #     urgent = {
    #       background    = "#${theme.base2}";
    #       backgroundAlt = "#${theme.base3}";
    #       foreground    = "#${theme.fg}";
    #       highlight  = {
    #         background = "#${theme.base5}";
    #         foreground = "#${theme.fg}";
    #       };
    #     };


  };
}
