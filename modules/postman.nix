{ }:
{
  home =
    { pkgs, lib, ... }:
    {
      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "postman" ];
      home.packages = [ pkgs.postman ];
    };
}
