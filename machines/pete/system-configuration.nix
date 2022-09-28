{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix
              ../../wm/xmonad.nix
            ];

  boot.loader = {
    systemd-boot.enable = true;
  };

  networking = {
    hostName = "pete";
    interfaces.enp0s25.useDHCP = true;
    interfaces.wlp3s0.useDHCP  = true;
  };

  services.xserver = {
    videoDrivers = [ "modesetting" ];
    useGlamor    = true;
    displayManager.defaultSession = "none+xmonad";
  };

  # NOTE: Needed this for Herbert, need this for Pete?
  hardware ={
    opengl = {
      enable = true;
      setLdLibraryPath = true;
      extraPackages = [ pkgs.mesa.drivers ];
    };

    cpu.intel.updateMicrocode = true;
  };


  system.stateVersion = "21.03";

  # systemd.services.NetworkManager-wait-online.enable = false;
}
