{ pkgs, ... }:
{
  home.packages = [
    pkgs.blueberry
    pkgs.gnome-bluetooth
  ];
}
