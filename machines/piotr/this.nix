# { config, lib, pkgs, ... }:

{
  syscfg   = import ./system-configuration.nix;
  homecfg  = import ./home-configuration.nix;
  isLaptop = true;
  theme    = import ../../theme/tomorrow-night.nix;
}
