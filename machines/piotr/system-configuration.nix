{
  imports = [ ./hardware-configuration.nix
              ../../wm/xmonad.nix
            ];

  boot.loader = {
    systemd-boot.enable = true;
  };

  networking = {
    hostName = "piotr";
    interfaces.enp0s25.useDHCP = true;
    interfaces.wlp3s0.useDHCP  = true;
  };

  services.xserver = {
    videoDrivers = [ "modesetting" ];
    useGlamor    = true;
    displayManager.defaultSession = "none+xmonad";
  };

  # NOTE: Needed this for Herbert, need this for Piotr?
  # hardware ={
  #   opengl = {
  #     enable = true;
  #     setLdLibraryPath = true;
  #     driSupport32Bit = true;
  #   };

  #   cpu.intel.updateMicrocode = true;
  # };

  system.stateVersion = "21.03";

  # NOTE: Needed this for Herbert, need this for Piotr?
  # systemd.services.NetworkManager-wait-online.enable = false;
}
