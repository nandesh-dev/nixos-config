# To install ltspice run "wine msiexec /i LTspiceXVII.msi"
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wineWowPackages.stable
    winetricks
  ];

  home.file.".local/bin/ltspice" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      export WINEPREFIX=~/.ltspice
      exec wine "$WINEPREFIX/dosdevices/c:/users/nandesh/AppData/Local/Programs/ADI/LTspice/LTspice.exe" "$@"
    '';
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
