# { config, lib, pkgs, ... }:

{
  syscfg   = import ./system-configuration.nix;
  homecfg  = import ./home-configuration.nix;
  isLaptop = false;
  theme    = import ../../theme/nord.nix;
}
