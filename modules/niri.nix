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

          workspaces = {
            "01-primary" = {
              name = "primary";
            };
            "02-secondary" = {
              name = "secondary";
            };
            "03-tertiary" = {
              name = "tertiary";
            };
            "04-background" = {
              name = "background";
            };
            "05-chat" = {
              name = "chat";
            };
          };

          layout = {
            gaps = 8;

            default-column-width = {
              proportion = 0.5;
            };

            preset-column-widths = [
              { proportion = 0.3; }
              { proportion = 0.5; }
              { proportion = 1.0; }
            ];
          };

          spawn-at-startup = [
            {
              argv = [
                (lib.getExe pkgs.vicinae)
                "server"
              ];
            }
            {
              argv = [ (lib.getExe inputs.noctalia.packages.${pkgs.system}.default) ];
            }
          ];

          window-rules = [
            {
              border.enable = false;
              focus-ring.enable = false;
              opacity = 0.9;
              geometry-corner-radius = {
                bottom-left = 12.0;
                bottom-right = 12.0;
                top-left = 12.0;
                top-right = 12.0;
              };
              clip-to-geometry = true;
            }
            {
              matches = [ { is-focused = true; } ];
              opacity = 1.0;
            }
            {
              matches = [ { app-id = "brave-browser"; } ];
              default-column-width = {
                proportion = 1.0;
              };
            }
          ];
          hotkey-overlay.skip-at-startup = true;

          xwayland-satellite = {
            path = (lib.getExe pkgs.xwayland-satellite);
          };

          binds = {
            "Mod+Return" = {
              repeat = false;
              action.spawn = lib.getExe pkgs.kitty;
            };
            "Mod+D" = {
              repeat = false;
              action.spawn = [
                (lib.getExe pkgs.vicinae)
                "toggle"
              ];
            };
            "Mod+B" = {
              repeat = false;
              action.spawn = [
                (lib.getExe pkgs.brave)
              ];
            };
            "Mod+Shift+E" = {
              repeat = false;
              action.spawn = [
                (lib.getExe inputs.noctalia.packages.${pkgs.system}.default)
                "ipc"
                "call"
                "sessionMenu"
                "toggle"
              ];
            };

            "Mod+Q".action.close-window = { };

            "Mod+1".action.focus-workspace = "primary";
            "Mod+2".action.focus-workspace = "secondary";
            "Mod+3".action.focus-workspace = "tertiary";
            "Mod+4".action.focus-workspace = "background";
            "Mod+5".action.focus-workspace = "chat";

            "Mod+Shift+1".action.move-window-to-workspace = "primary";
            "Mod+Shift+2".action.move-window-to-workspace = "secondary";
            "Mod+Shift+3".action.move-window-to-workspace = "tertiary";
            "Mod+Shift+4".action.move-window-to-workspace = "background";
            "Mod+Shift+5".action.move-window-to-workspace = "chat";

            "Mod+H".action.focus-column-left = { };
            "Mod+L".action.focus-column-right = { };
            "Mod+J".action.focus-window-down = { };
            "Mod+K".action.focus-window-up = { };

            "Mod+Left".action.focus-column-left = { };
            "Mod+Right".action.focus-column-right = { };
            "Mod+Down".action.focus-window-down = { };
            "Mod+Up".action.focus-window-up = { };

            "Mod+Shift+H".action.move-column-left = { };
            "Mod+Shift+L".action.move-column-right = { };
            "Mod+Shift+J".action.move-window-down = { };
            "Mod+Shift+K".action.move-window-up = { };

            "Mod+Shift+Left".action.move-column-left = { };
            "Mod+Shift+Right".action.move-column-right = { };
            "Mod+Shift+Down".action.move-window-down = { };
            "Mod+Shift+Up".action.move-window-up = { };

            "Mod+Ctrl+H".action.focus-monitor-left = { };
            "Mod+Ctrl+L".action.focus-monitor-right = { };
            "Mod+Ctrl+J".action.focus-monitor-down = { };
            "Mod+Ctrl+K".action.focus-monitor-up = { };

            "Mod+Ctrl+Left".action.focus-monitor-left = { };
            "Mod+Ctrl+Right".action.focus-monitor-right = { };
            "Mod+Ctrl+Down".action.focus-monitor-down = { };
            "Mod+Ctrl+Up".action.focus-monitor-up = { };

            "Mod+Minus".action.switch-preset-column-width-back = { };
            "Mod+Equal".action.switch-preset-column-width = { };

            "Mod+F".action.maximize-column = { };
          };
        };
      };
    };
}
