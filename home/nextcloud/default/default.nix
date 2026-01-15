{ config, pkgs, ... }:
let
  command = local: remote: ''
    ${pkgs.rclone}/bin/rclone sync ${local} nextcloud:${remote} \
      --exclude "**/node_modules/" \
      --links
  '';
in
{
  systemd.user.services.nextcloud-sync = {
    Unit = {
      Description = "Nextcloud Sync";
      After = [ "network-online.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = [
        (command "Documents" "Documents")
        (command "Downloads" "Downloads")
        (command "Screenshots" "Screenshots")
        (command "Pictures" "Camera")
      ];
      KillSignal = "SIGINT";
      TimeoutStopSec = 10;
    };
  };
}
