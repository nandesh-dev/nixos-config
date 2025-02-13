{ pkgs, ... }:
{
  xdg.configFile."i3" = {
    source = ./.config/i3;
    recursive = true;
  };

  xdg.configFile."picom" = {
    source = ./.config/picom;
    recursive = true;
  };

  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        bars = [ ];
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-GTK-Dark";
      package = pkgs.magnetic-catppuccin-gtk;
    };
  };

  home.sessionVariables = {
    GTK_THEME = "Catppuccin-GTK-Dark";
  };

  home.packages = [
    pkgs.gnome-themes-extra
    pkgs.feh
    pkgs.picom
    pkgs.wireplumber
    pkgs.brightnessctl
    pkgs.dex
    pkgs.maim
    pkgs.xdotool
    pkgs.xclip
    pkgs.copyq
    pkgs.dmenu
  ];
}
