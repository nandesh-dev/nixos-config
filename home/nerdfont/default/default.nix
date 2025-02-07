{ pkgs, ... }:
{
  home.packages = [ (pkgs.nerdfonts.override { fonts = [ "CascadiaMono" ]; }) ];
}
