{ self, inputs, ... }:
{
  flake.homeModules.neovim =
    { pkgs, lib, ... }:
    {
      home.sessionVariables = {
        npm_config_store_dir = "${config.home.homeDirectory}/.cache/pnpm-store";
      };

      home.packages = with pkgs; [
        nixfmt
        nil

        stylua
        lua-language-server

        prettier
        typescript-language-server
        nodejs_26
        pnpm

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
    };
}
