{ self, inputs, ... }:
{
  flake.homeModules.stylix =
    { pkgs, lib, ... }:
    {
      imports = [
        inputs.stylix.homeModules.stylix
      ];

      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-cave-light.yaml";
      };
    };
}
