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
            {
              directory = "/var/lib/nixos";
              inInitrd = true;
            }
          ];

          files = [
            {
              file = "/etc/machine-id";
              inInitrd = true;
            }
          ];

          # Preserve user files
          # users.yurii = {
          #   directories = [
          #     ".ssh"
          #     ".mozilla"
          #   ];
          #
          #   files = [
          #
          #   ];
          # };
        };
      };
    };
}
