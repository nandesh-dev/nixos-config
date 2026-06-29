{ self, inputs, ... }:
{
  flake.homeModules.noctalia =
    { pkgs, lib, ... }:
    {
      imports = [ inputs.noctalia.homeModules.default ];

      programs.noctalia-shell = {
        enable = true;
        settings = {
          settingsVersion = 0;
          bar = {
            position = "left";
            widgets = {
              left = [
                {
                  id = "Clock";
                }
                {
                  id = "SystemMonitor";
                }
                {
                  id = "TaskBar";
                }
                {
                  id = "MediaMini";
                }
              ];
              center = [
                {
                  id = "Workspace";
                }
              ];
              right = [
                {
                  id = "Tray";
                }
                {
                  id = "NotificationHistory";
                }
                {
                  id = "Battery";
                }
                {
                  id = "Volume";
                }
                {
                  id = "Brightness";
                }
                {
                  id = "ControlCenter";
                }
              ];
            };
          };
          general = {
            enableShadows = true;
            enableBlurBehind = true;
            telemetryEnabled = false;
            showChangelogOnStartup = false;
          };
          location = {
            name = "Chennai";
            hideWeatherCityName = true;
          };
          sessionMenu = {
            largeButtonsStyle = true;
            powerOptions = [
              {
                action = "shutdown";
                enabled = true;
                keybind = "1";
              }
              {
                action = "reboot";
                enabled = true;
                keybind = "2";
              }
              {
                action = "lock";
                enabled = true;
                keybind = "3";
              }
              {
                action = "suspend";
                enabled = true;
                keybind = "4";
              }
              {
                action = "hibernate";
                enabled = true;
                keybind = "5";
              }
            ];

          };
          wallpaper = {
            enabled = true;
            directory = ./wallpapers;
            transitionType = [ "fade" ];
          };
        };
      };
    };
}
