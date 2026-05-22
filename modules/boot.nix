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
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      boot.initrd.availableKernalModules = [
        "xhci_pci"
        "ahchi"
        "usbhid"
        "sd_mod"
        "sr_mod"
      ];
      boot.initrd.kernalModules = [ ];

      boot.kernalModules = [ ];
      boot.extraModulePackages = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
