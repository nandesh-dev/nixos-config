{ ... }:

let
  pkgs = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/d78a143.tar.gz";
    sha256 = "14v6hqcxmfn1lxbvnfavkll9z462ziiydj4krc3hq9b6pxw59cqh";
  }) { };
in
{
  home.packages = [
    pkgs.vicinae
  ];
}
