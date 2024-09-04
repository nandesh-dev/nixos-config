{ }:
{
  home =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.yazi ];
    };
}
