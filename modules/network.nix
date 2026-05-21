{ self, inputs, ... }:
{
  flake.nixosModules.network =
    { pkgs, lib, ... }:
    {
      networking.hostName = "del-inspiron-14";
      networking.networkmanager.enable = true;
    };
}
