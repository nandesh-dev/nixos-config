{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.hardware =
    {
      lib,
      config,
      ...
    }:
    {
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      hardware.enableRedistributableFirmware = true;
    };
}
