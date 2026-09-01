{ self, inputs, ... }:
{
  flake.homeModules.kicad =
    { pkgs, lib, ... }:
    {
      home.packages = [
        pkgs.kicad
      ];
    };
}
