{ self, inputs, ... }:
{
  flake.homeModules.gtk =
    { pkgs, lib, ... }:
    {
      gtk = {
        enable = true;
        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };
      };
    };
}
