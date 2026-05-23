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
      imports = [ inputs.niri.nixosModules ];

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
    { pkgs, lib, ... }:
    {
      imports = [ inputs.niri.homeModules.niri ];

      programs.niri = {
        enable = true;

        settings.binds = {
          "Mod+Return" = {
            repeat = false;
            action.spawn = lib.getExe pkgs.kitty;
          };
          "Mod+Q".action.close-window = { };
        };
      };
    };
}
