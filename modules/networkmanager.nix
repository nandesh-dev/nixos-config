{ }:
{
  groups = [ "networkmanager" ];
  system =
    { ... }:
    {
      networking.networkmanager.enable = true;
    };
}
