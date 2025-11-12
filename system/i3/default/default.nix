{ ... }:
{
  services.xserver = {
    enable = true;

    displayManager.gdm.enable = true;

    windowManager.i3.enable = true;
  };

  services.displayManager = {
    defaultSession = "none+i3";
  };
}
