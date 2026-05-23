{ self, inputs, ... }:
{
  flake.nixosModules.niri =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      programs.niri.enable = true;

      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${config.programs.niri.package}/bin/niri-session";
            user = "nandesh";
          };
        };
      };

      systemd.user.services.niri.enableDefaultPath = false;
    };

  flake.homeModules.niri =
    { pkgs, ... }:
    {
      imports = [ inputs.niri.homeModules.niri ];

      programs.niri = {
        enable = true;

        settings.binds = {
          "Mod+Return".action = {
            repeat = false;
            spawn = [
              lib.getExe
              pkgs.kitty
            ];
          };
          "Mod+Q".action.close-window = null;
        };
      };
    };
}
