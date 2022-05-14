Here we pin package repositories to a particular commit, this prevents
continuous, large reinstallations whenever small updates happen.

To get info on which commit is safe to pin to, checkout [Nixos Infra Status](https://status.nixos.org/).

The syntax for a pin is:
- https://github.com/NixOS/nixpkgs/archive/REF_HASH.tar.gz
- https://github.com/NixOS/nixpkgs/archive/refs/tags/TAG_NAME.tar.gz
