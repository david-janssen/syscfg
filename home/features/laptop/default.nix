{ pkgs, ... }:
let
  batmon = pkgs.callPackage ./batmon {};
in

{
  home.packages = with pkgs; [
    batmon
  ];

  systemd.user = {
    timers.batmon = {
      Unit.Description = "trigger the battery monitor every minute";
      Timer.OnCalendar = "minutely";
      Install.WantedBy = [ "timers.target" ];
    };

    services.batmon = {
      Unit.Description = "warn of impending doom if battery levels are critical";
      Service = {
        Type = "simple";
        ExecStart = "${batmon}/bin/batmon";
      };
      Install.WantedBy = [ "default.target" ];
    };
  };
}
