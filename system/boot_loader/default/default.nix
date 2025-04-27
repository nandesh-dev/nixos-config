{ ... }:
{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    useOSProber = true;
    efiSupport = true;
    device = "nodev";
  };
}
