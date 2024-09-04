{ }:
{
  home =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.git
        pkgs.gh
      ];
    };
}
