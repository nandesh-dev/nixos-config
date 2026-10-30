{ self, inputs, ... }:
{
  flake.homeModules.texstudio =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      home.packages = with pkgs; [
        texliveFull
        texstudio
      ];
    };
}
