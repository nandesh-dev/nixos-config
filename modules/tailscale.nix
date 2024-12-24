{ }:
{
  system =
    { pkgs, ... }:
    {
      services.tailscale.enable = true;
    };
}
