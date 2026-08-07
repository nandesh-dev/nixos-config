{ self, inputs, ... }:
{
  flake.homeModules.qgroundcontrol =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      home.packages = with pkgs; [
        qgroundcontrol
      ];
    };
}
