{ self, inputs, ... }:
{
  flake.nixosModules.pipewire =
    { pkgs, lib, ... }:
    {
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
    };
}
