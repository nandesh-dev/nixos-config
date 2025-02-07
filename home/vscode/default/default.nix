{ pkgs, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      jdinhlife.gruvbox
      bradlc.vscode-tailwindcss
      bbenoist.nix
    ];
    userSettings = {
      "editor.fontFamily" = "CaskaydiaMono Nerd Font Mono";
    };
  };
}
