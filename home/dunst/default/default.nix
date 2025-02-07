{ pkgs, ... }:
{
  home.packages = [ pkgs.dunst ];

  xdg.configFile."dunst" = {
    source = ./.config/dunst;
    recursive = true;
  };
}
