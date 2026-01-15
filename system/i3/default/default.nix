{ ... }:
{
  services.xserver = {
    enable = true;

    windowManager.i3.enable = true;
  };

  services.displayManager = {
    gdm.enable = true;
    defaultSession = "none+i3";
  };
}
