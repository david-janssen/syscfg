{ stdenv, config, lib, pkgs, ... }:

# My experiment in 'simply wrapping' a shellscript with nix.
#
# I really don't like that most examples 'interpolate' the required packages for
# shellscripts by writing the entire thing in 'nix', and then using
# '${pgks.coreutils}/bin/cat' whenever they want to cat something. This works
# for 1-3 liners, but being able to write a proper script in using editor
# support and code-highlighting and the possibility to interactively test it in
# the shell is very important.
#
# Therefore, here is a way to wrap simple shell-scripts: write them normally,
# then wrap them in a new package that includes all the required 'buildInputs'
# and which exports them to PATH before calling the raw script. This is not the
# cleanest for code that is meant to be shared, but for little sys-hacks, it is
# more user-friendly.

let
  batmon-raw = pkgs.writeShellScriptBin "batmon-raw"
    (builtins.readFile ./batmon.sh);
in

stdenv.mkDerivation {
  name = "batmon";
  buildInputs = with pkgs; [ vlc coreutils acpi batmon-raw gnused libnotify];
  unpackPhase = "true";
  installPhase = with pkgs; ''
      mkdir -p "$out/bin"
      echo "#! ${stdenv.shell}" >> "$out/bin/batmon"
      echo "export PATH=$PATH" >> "$out/bin/batmon"
      echo "exec ${batmon-raw}/bin/batmon-raw" >> "$out/bin/batmon"
      chmod +x $out/bin/batmon
  '';
}
