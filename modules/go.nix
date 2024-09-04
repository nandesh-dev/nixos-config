{ }:
{
  home =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.go ];
    };
}
