{ }:
{
  system =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.alacritty ];
    };
  home =
    { pkgs, ... }:
    {
      home.packages = [ (pkgs.nerdfonts.override { fonts = [ "CascadiaMono" ]; }) ];
    };
}
