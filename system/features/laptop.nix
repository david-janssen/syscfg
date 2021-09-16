{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    light # Manage the backlight
  ];

  services = {
    # Battery monitoring
    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 5;
    };

    # Touchpad drivers and settings
    xserver.libinput = {
      enable = true;
      touchpad.disableWhileTyping = true;
    };
  };
}
