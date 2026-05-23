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
      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${config.programs.niri.package}/bin/niri-session";
            user = "nandesh";
          };
        };
      };
    };

  flake.homeModules.niri =
    { pkgs, lib, ... }:
    {
      imports = [ inputs.niri.homeModules.niri ];

      programs.niri = {
        enable = true;

        settings = {
          input = {
            mod-key = "Alt";
          };
          binds = {
            "Mod+Return" = {
              repeat = false;
              action.spawn = lib.getExe pkgs.kitty;
            };
            "Mod+D" = {
              repeat = false;
              action.spawn = lib.getExe pkgs.vicinae;
            };
            "Mod+Q".action.close-window = { };
          };
        };
      };
    };
}
