{ self, inputs, ... }:
{
  flake.nixosModules.template = { pkgs, lib, ... }: { };

  flake.homeModules.template = { pkgs, lib, ... }: { };
}
