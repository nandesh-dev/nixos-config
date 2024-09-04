{ }:
{
  home =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.freefilesync ];
    };
}
