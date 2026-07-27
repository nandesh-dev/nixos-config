{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.boot =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      boot.loader = {
        grub = {
          enable = true;
          device = "nodev";
          efiSupport = true;
          efiInstallAsRemovable = true;
          theme = pkgs.minimal-grub-theme;
        };
      };
      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "vmd"
        "nvme"
        "usbhid"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    };
}
