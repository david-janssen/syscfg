{ config, lib, pkgs, ... }:

let
  this = import ./machine/current/this.nix;
in

{
  imports = [
    this.syscfg
  ] ++ (if this.isLaptop then [./features/laptop] else []);

  # Run networking through network-manager
  networking = {
    networkmanager = {
      enable   = true;
      packages = [ pkgs.networkmanager_openvpn ];
    };
    useDHCP = false;
    firewall.enable = true;
  };

  # Locale and location settings
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone      = "Europe/Amsterdam";

  # Packages that either:
  # - Are required for any of the system-level services I've setup
  # - Might one day be useful to Pili
  environment.systemPackages = with pkgs; [
    audacity        # edit sound files
    freetube        # youtube without the manipulation
    gimp            # gnu image manipulation program
    gitFull         # how would we exist without it?
    gnome.nautilus  # file-manager
    libreoffice     # office suite
    pavucontrol     # audio-controller for pulseaudio
    unzip           # because people use zip-files
    vim             # because sometimes you wan't to be quick
    vlc             # my favorite media player
    wget            # pull stuff from the internet
    xorg.xrandr     # manage displays
    zoom-us         # to engage with normies
  ];

  # Load a bunch of fonts
  fonts.fonts = with pkgs; [
    corefonts
    liberation_ttf
    (nerdfonts.override {fonts = [ "Mononoki" "FiraCode" ];})
  ];

  # Manage audio with pulseaudio
  hardware.pulseaudio.enable = true;

  services = {
    # Run an sshd daemon
    openssh = {
      enable    = true;
      allowSFTP = true;
    };

    # Run a CUPS daemon
    printing.enable = true;
  };


  programs = {
    # Always run a gpg-agent to keep identities cached
    gnupg.agent = {
      enable           = true;
      enableSSHSupport = true;
    };

    # Always want access to dconf to configure Gnome-apps
    dconf.enable = true;

    # Always make sure fish is installed
    fish.enable = true;
  };

  users.extraUsers."david" = {
    name           = "david";
    extraGroups    = [ "docker" "input" "networkmanager" "nixconf" "wheel" ];
    hashedPassword = "$6$P9tj0Fe9$c6V62PZza7aBqnBaAtqgLGlT2HccThWZ5dfrbZ2/kcaAWPAEOSxafbwQxbx1u1fUUQDWlvdCAtnWBAeJVKOhw.";
    isNormalUser   = true;
    shell          = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    # Automate `nix-store --optimise`
    autoOptimiseStore = true;

    # Setup auto-gc parameters
    gc = {
      automatic = true;
      dates     = "weekly";
      options   = "--delete-older-than 7d";
    };

    # For nix-direnv
    extraOptions = ''
      keep-outputs     = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';

    trustedUsers = [ "root" "david" ];
  };

  # Is this unwise? Since I am a hermit maybe not.
  security.sudo.wheelNeedsPassword = false;


  services = {

    # Run a dbus service with dconf
    dbus = {
      enable   = true;
      packages = [ pkgs.gnome.dconf ];
    };

    # Run an X-server
    xserver = {

      # Enable X11 and set keyboard layout to US
      enable = true;
      layout = "us";

      # Use lightdm as the display manager
      displayManager.lightdm = {
        enable = true;
        background = this.theme.wallpaper;
        greeters.gtk = {
          enable = true;
          theme.name = "Adwaita-dark";
        };
      };
    };
  };
}
