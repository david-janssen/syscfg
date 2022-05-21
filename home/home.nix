{ config, lib, pkgs, stdenv, ... }:

let

  this = import ./machine/current/this.nix;

  # Packages that are useful but are not:
  # - Defined in the system configuration
  # - Defined by some 'program' setting in home-manager
  defaultPkgs = with pkgs; [
    anki
    any-nix-shell   # fish support for nix-shell
    bat             # `cat` but better
    cachix          # nix caching
    dmenu           # application launcher
    duf             # disk usage/free utility
    evtest          # gather info on input events
    fd              # `find` but only for files
    imagemagick
    killall         # kill programs by name
    libnotify       # send notification messages
    manix           # more nix documentation
    multilockscreen # screen-locker util
    mu              # email-indexer and emacs client
    ncdu            # a much prettier `du`
    neofetch        # command-line sys-info
    nix-doc         # search nix documentation
    nix-index       # search nix-pkgs
    nixfmt          # auto-format nix syntax
    paprefs         # pulseaudio preferences
    pasystray       # pulseaudio systray app
    prettyping      # ping but pretty
    ripgrep         # fast grep
    rnix-lsp        # nix lsp server
    stow            # deploy dirs as symlinks
    tldr            # man-page summary generator
    tree            # tree-view of fs
    udiskie         # control udiskie daemon from prompt
    vlc             # a great media player
    xclip           # clipboard utility
    xorg.xev        # event-discovery utility
    youtube-dl      # grabbing media from youtube
    zathura         # a great pdf-viewer

    python39Packages.ipython # python repl, but nice
  ];

in
{
  news.display = "silent"; # Hide home-manager's update notifications

  nixpkgs.config = {
    allowUnfree = true;
  };

  imports = [
    # Include config for this machine
    this.homecfg

    # Dispatch further features, passing 'this'
    (import ./programs { inherit config pkgs this; })
    (import ./services { inherit config pkgs this; })
    (import ./features/xmonad { inherit pkgs this;  })

    # Other features that don't depend on 'this'
    ./features/mail
    ./features/dev/c.nix
    ./features/dev/haskell.nix
  ] ++ (if this.isLaptop
        then [ (import ./features/laptop { inherit stdenv pkgs this; }) ]
        else []);

  gtk = {
    enable = true;
    iconTheme = {
      name    = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };

  # Configure my XDG directories
  xdg = {
    enable = true;
    userDirs = {
      enable            = true;
      createDirectories = true;
      desktop           = "\$HOME/dcs/desk";
      documents         = "\$HOME/dcs";
      download          = "\$HOME/dwn";
      music             = "\$HOME/dcs/audio/music";
      pictures          = "\$HOME/dcs/pics";
      publicShare       = "\$HOME/dcs";
      templates         = "\$HOME/dcs";
      videos            = "\$HOME/dcs/vids";
    };
  };

  home = {
    username = "david";
    homeDirectory = "/home/david";

    packages = defaultPkgs;

    sessionVariables = {
      DISPLAY = ":0";
      EDITOR  = "emacs";
    };

    sessionPath = [
      "/home/david/prj/syscfg/bin" # where the `mksys` script lives
      "/home/david/.emacs.d/bin"   # doom-emacs scripts
      "/home/david/.local/bin"     # For if I really need a quick and dirty stateful solution
    ];
  };

  # restart services on change
  systemd.user.startServices = "sd-switch";

  services = {
    # Caching for direnvs using nix
    lorri.enable = true;

    # Change brightness throughout day
    gammastep = {
      enable = true;
      latitude = 50.998;
      longitude = 5.869;
      settings.general.fade = 0;
      temperature.night = 3000;   # A little redder than the default
    };
  };

  programs = {
    autojump = {
      enable = true;
      enableFishIntegration = true;
    };

    bat.enable = true;

    broot = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    # a nicer `ls`
    exa = {
      enable = true;
      enableAliases = false;
    };

    feh.enable = true;

    fzf = {
      enable = true;
      enableFishIntegration = true;
      defaultCommand = "fd --type file --follow";
      defaultOptions = [ "--height 20%" ];
      fileWidgetCommand = "fd --type file --follow";
    };

    gpg.enable = true;

    home-manager.enable = true;

    htop = {
      enable = true;
      settings = {
        sort_direction = true;
        sort_key = "PERCENT_CPU";
      };
    };


    ssh.enable = true;

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [];
    };

  };
}
