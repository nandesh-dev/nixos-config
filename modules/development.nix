{ self, inputs, ... }:
{
  flake.homeModules.development =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      home.sessionVariables = {
        PNPM_HOME = "${config.home.homeDirectory}/.cache/pnpm-store";
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
