{ pkgs, ... }:
{
  home.packages = [
    pkgs.nodejs_24
    pkgs.pnpm
  ];
}
