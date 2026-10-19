{ self, inputs, ... }:
{
  flake.homeModules.kitty =
    { pkgs, lib, ... }:
    {
      programs.kitty.enable = true;

      programs.alacritty.enable = true;

      programs.bash = {
        enable = true;
        shellAliases = {
          nrs = "sudo nixos-rebuild switch --flake .#desktop --accept-flake-config";
          nrt = "sudo nixos-rebuild test --flake .#desktop --accept-flake-config";
        };
      };
    };
}
