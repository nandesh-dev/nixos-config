{ self, inputs, ... }:
{
  flake.homeModules.libreoffice =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      home.packages = with pkgs; [
        libreoffice
      ];
    };
}
