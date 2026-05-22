{ self, inputs, ... }:
{
  flake.nixosModules.preferences =
    { pkgs, lib, ... }:
    {
      time.timeZone = "Europe/Kyiv";
      i18n.defaultLocale = "en_US.UTF-8";
    };
}
