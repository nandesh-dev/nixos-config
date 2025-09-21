{ pkgs, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  programs.vscode = {
    enable = true;
  };
}
