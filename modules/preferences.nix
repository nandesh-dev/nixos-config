{ self, inputs, ... }:
{
  flake.nixosModules.preferences =
    { pkgs, lib, ... }:
    {
      services.timesyncd.enable = true;
      time.timeZone = "Asia/Kolkata";
      i18n.defaultLocale = "en_US.UTF-8";
    };
}
