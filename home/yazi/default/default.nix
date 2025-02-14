{ pkgs, ... }:
{
  home.packages = [ pkgs.yazi ];

  xdg.configFile."yazi" = {
    source = ./.config/yazi;
    recursive = true;
  };
}
