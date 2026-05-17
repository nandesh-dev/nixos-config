{
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
}
