{ config, pkgs, this, ... }:
let

  theme = this.theme;

  pb = pkgs.polybar.override {
    pulseSupport  = true;
  };

in
{
  services.polybar = {

    enable = true;
    package = pb;
    script = "polybar main 2>${config.xdg.configHome}/polybar/logs/main.log & disown";

    settings = {

      "color" = {
        fg  = "#${theme.fg}";
        bg  = "#${theme.bg}";
        yay = "#${theme.green}";
        nay = "#${theme.red}";
        meh = "#${theme.dark-blue}";
      };

      "global/wm" = {
        margin = {
          top = 0;
          bottom = 0;
        };
      };

      "settings" = {
        screenchange.reload = true;
      };

      "bar/main" = {
        width = "100%";
        height = 24;
        fixed-center = true;

        background = "\${color.bg}";
        foreground = "$\{color.fg}";

        margin = {
          top = 0;
          bottom = 0;
        };

        padding = {
          left = 0;
          right = 1;
        };

        module.margin = {
          left = 0;
          right = 2;
        };

        font = [
          "Mononoki Nerd Font:style=Medium:size=12;3"
        ];

        modules = {
          left = "xmonad";
          right = if this.isLaptop then "date battery" else "date";
        };

        enable.ipc = true; # Required to enable `polybar-msg`

        tray = {
          position = "right";
          padding = 5;
          background = "\${color.bg}";
        };
      };

      "module/date" = {
        type = "internal/date";
        interval = 1.0;
        date = "%{F#${theme.gray}}%m-%d@%{F-}%{F#${theme.fg}}%H%M%{F-}";
      };

      "module/battery" = {
        type = "internal/battery";
        battery = "BAT0";
        adapter = "ACAD";
        poll.interval = 5;
        time-format = "%H%M";

        label.charging = "%percentage%:%time%";
        format.charging = {
          text = "<label-charging>";
          background = "\${color.bg}";
          foreground = "\${color.yay}";
          padding = 0;
        };

        label.discharging = "%percentage%:%time%";
        format.discharging = {
          text = "<label-discharging>";
          background = "\${color.bg}";
          foreground = "\${color.nay}";
          padding = 0;
        };

        label.full = {
          text = "F";
          background = "\${color.bg}";
          foreground = "\${color.meh}";
          padding = 0;
        };
      };

      "module/xmonad" = {
        type = "custom/script";
        exec = "${pkgs.xmonad-log}/bin/xmonad-log";
        tail = true;
      };
    };
  };
}
