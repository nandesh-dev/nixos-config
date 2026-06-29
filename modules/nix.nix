{ self, inputs, ... }:
{
  flake.nixosModules.nix =
    { pkgs, lib, ... }:
    {
      nix.settings = {
        substituters = [
          "https://cache.nixos.org"
          "https://nix-community.cachix.org"
          "https://noctalia.cachix.org"
        ];

        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        ];

        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
    };
}
