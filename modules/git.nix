{ self, inputs, ... }:
{
  flake.homeModules.git =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        git
        gh
      ];
    };
}
