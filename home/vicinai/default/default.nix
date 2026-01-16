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

  xdg.enable = true;
  xdg.desktopEntries."vicinae-url-handler" = {
    name = "Vicinae Launcher";
    exec = "${pkgs.vicinae}/bin/vicinae %u";
    terminal = false;
    categories = [ "Utility" ];
    mimeType = [
      "x-scheme-handler/vicinae"
      "x-scheme-handler/raycast"
    ];
  };
}
