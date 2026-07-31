{ self, inputs, ... }:
{
  flake.homeModules.ssh =
    { pkgs, lib, ... }:
    {
      home.file.".ssh/id_ed25519.pub".source = ./id_ed25519.pub;
    };
}
