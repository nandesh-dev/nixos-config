{ self, inputs, ... }:
{
  flake.nixosModules.development =
    { pkgs, lib, ... }:
    {
      imports = [
        inputs.probe-rs-rules.nixosModules.x86_64-linux.default
      ];

      hardware.probe-rs.enable = true;
    };
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
        basedpyright

        marksman
        vscode-langservers-extracted
      ];
    };
}
