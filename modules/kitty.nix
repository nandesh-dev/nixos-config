{ self, inputs, ... }:
{
  flake.homeModules.kitty = { pkgs, lib, ... }: {
    programs.kitty.enable = true;

    programs.alacritty.enable = true;
  };
}
