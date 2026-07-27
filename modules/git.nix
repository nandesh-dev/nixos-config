{ self, inputs, ... }:
{
  flake.homeModules.git =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        gh
      ];

      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "nandesh-dev";
            email = "nandesh.dev@gmail.com";
          };
          push = {
            autoSetupRemote = true;
          };
        };
      };
    };
}
