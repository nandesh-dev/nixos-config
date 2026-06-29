{ self, inputs, ... }:
{
  flake.nixosModules.nautilus =
    { pkgs, lib, ... }:
    {
      environment.systemPackages = [ pkgs.nautilus ];
      services.gvfs.enable = true;
      services.tumbler.enable = true;
    };
}
