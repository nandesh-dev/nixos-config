{ self, inputs, ... }:
{
  flake.homeModules.telegram =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.telegram-desktop ];
    };
}
