{ self, inputs, ... }:
{
  flake.homeModules.neovim =
    { pkgs, lib, ... }:
    {
      programs.neovim = {
        enable = true;

        extraPackages = with pkgs; [
          nixfmt
          nil

          stylua
          lua-language-server

          prettier
          typescript-language-server

          stylelint

          rustfmt
          rust-analyzer

          go
          gopls

          buf

          black
          pyright

          marksman
          vscode-langservers-extracted
        ];

        initLua = builtins.readFile ./init.lua;
      };
    };
}
