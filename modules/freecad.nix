{ self, inputs, ... }:
{
  flake.homeModules.freecad =
    { pkgs, lib, ... }:
    {
      home.packages = [
        pkgs.freecad
      ];
    };
}
