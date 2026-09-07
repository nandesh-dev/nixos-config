{ self, inputs, ... }:
{
  flake.homeModules.obsidian =
    { pkgs, lib, ... }:
    {
      home.packages = [
        pkgs.obsidian
      ];
    };
}
