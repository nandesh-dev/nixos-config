{ self, inputs, ... }:
{
  flake.homeModules.stylix =
    { pkgs, lib, ... }:
    {
      imports = [
        inputs.stylix.nixosModules.stylix
      ];

      stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-cave-light.yaml";
    };
}
