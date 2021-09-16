{ config, lib, pkgs, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        alignment            = "center";
        frame_width          = 1;
        geometry             = "-50x10-25+200";
        horizontal_padding   = 20;
        transparency         = 0;
        frame_color          = "#282828";
        font                 = "Mononoki Nerd Font 15";
        stack_duplicates     = false;
        markup               = "full" ;
        bounce_freq          = 0;
        follow               = "none";
        format               = "<b>%s</b>\n%b";
        idle_threshold       = 120;
        ignore_newline       = false;
        indicate_hidden      = true;
        line_height          = 0;
        monitor              = 0;
        separator_height     = 0;
        show_age_threshold   = 60;
        show_indicators      = true;
        shrink               = true;
        sort                 = true;
        startup_notification = false;
        sticky_history       = true;
        word_wrap            = true;
      };
      shortcuts = {
        close     = "mod4+ctrl+n";
        close_all = "mod4+ctrl+o";
        history   = "mod4+ctrl+e";
        context   = "mod4+ctrl+i";
      };
      urgency_low = {
        background = "#689d6a";
        foreground = "#ebdbb2";
        timeout    = 15;
      };
      urgency_normal = {
        background = "#458588";
        foreground = "#ebdbb2";
        timeout    = 20;
      };
    };
  };
}
