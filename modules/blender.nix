{ self, inputs, ... }:
{
  flake.homeModules.blender =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      home.packages = with pkgs; [
        blender
      ];
    };
}
