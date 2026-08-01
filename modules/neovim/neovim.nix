{ self, inputs, ... }:
{
  flake.homeModules.neovim =
    { pkgs, lib, ... }:
    {
      programs.neovim = {
        enable = true;

        extraPackages = with pkgs; [
          ripgrep
        ];

        initLua = builtins.readFile ./init.lua;
      };
    };
}
