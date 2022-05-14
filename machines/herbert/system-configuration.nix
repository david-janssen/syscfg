{
  imports = [ ./hardware-configuration.nix
              # ../../features/virtualisation.nix
              ../../features/steam.nix
              ../../wm/xmonad.nix
            ];

  boot.loader = {
    systemd-boot.enable = true;
  };

  networking = {
    hostName = "herbert";
    interfaces.enp3s0.useDHCP = true;
  };

  services.xserver = {
    videoDrivers = [ "nvidia" ];
    useGlamor    = true;
    # displayManager.defaultSession = "none+xmonad";
  };

  hardware ={
    opengl = {
      enable = true;
      setLdLibraryPath = true;
      driSupport32Bit = true;
    };

    cpu.intel.updateMicrocode = true;
  };

  system.stateVersion = "20.03";

  # Don't need this and it has issues.
  systemd.services.NetworkManager-wait-online.enable = false;
}
