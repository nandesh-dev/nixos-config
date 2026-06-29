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
        };
        efi.canTouchEfiVariables = true;
      };

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "ahci"
        "usbhid"
        "sd_mod"
        "sr_mod"
      ];
      boot.initrd.kernelModules = [ ];

      boot.kernelModules = [ ];
      boot.extraModulePackages = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
