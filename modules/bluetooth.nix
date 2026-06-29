{ self, inputs, ... }:
{
  flake.nixosModules.bluetooth =
    { pkgs, lib, ... }:
    {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
    };
}
