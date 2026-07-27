{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.docker =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {
      virtualisation.docker = {
        enable = true;
      };
    };
}
