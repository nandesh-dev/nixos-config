{ self, inputs, ... }:
{
  flake.nixosModules.ssl =
    { pkgs, lib, ... }:
    {
      security.pki.certificateFiles = [
        ./certificate.pem
      ];
    };
}
