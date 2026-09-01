{ self, inputs, ... }:
{
  flake.homeModules.prismlauncher =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.prismlauncher
        pkgs.openjdk21
      ];
    };
}
