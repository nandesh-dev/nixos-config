{ }:
{
  groups = [
    "render"
    "video"
  ];

  home =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.blender ];
    };
}
