{ self, inputs, ... }:
{
  flake.nixosModules.preservation =
    { pkgs, lib, ... }:
    {
      imports = [
        inputs.preservation.nixosModules.default
      ];

      preservation = {
        enable = true;

        preserveAt."/persistent" = {
          directories = [
            "/etc/nixos"
            "/var/lib/bluetooth"
            "/var/db/sudo/lectured"
            "/var/lib/docker/"
            "/var/log"
            "/etc/NetworkManager/system-connections/"
            {
              directory = "/var/lib/nixos";
              inInitrd = true;
            }
          ];

          files = [
            {
              file = "/var/lib/sops/keys.txt";
              inInitrd = true;
            }
            {
              file = "/etc/machine-id";
              inInitrd = true;
              how = "symlink";
              configureParent = true;
            }
          ];

          users.nandesh = {
            directories = [
              ".local/"
              ".cache/"
              ".ssh/"
              ".config/BraveSoftware/Brave-Browser"
              ".arduinoIDE"
              ".arduino15"
              "Documents"
              "Projects"
            ];
            files = [ ];
          };
        };
      };

      systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];

      systemd.services.systemd-machine-id-commit = {
        unitConfig.ConditionPathIsMountPoint = [
          ""
          "/persistent/etc/machine-id"
        ];
        serviceConfig.ExecStart = [
          ""
          "systemd-machine-id-setup --commit --root /persistent"
        ];
      };
    };
}
