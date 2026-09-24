{ self, inputs, ... }:
{
  flake.homeModules.obsidian =
    { pkgs, lib, ... }:
    {
      nixpkgs.config.allowUnfree = true;
      home.packages = [
        pkgs.obsidian
      ];
    };
}
