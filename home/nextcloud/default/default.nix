{ config, pkgs, ... }:
let
  nextcloud = "${pkgs.nextcloud-client}/bin/nextcloudcmd";
  command =
    dir:
    "${pkgs.nextcloud-client}/bin/nextcloudcmd -n --non-interactive --path ${dir} ${dir} https://drive.kitty-velociraptor.ts.net";
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
        (command "Documents")
        (command "Downloads")
        (command "Screenshots")
      ];
      KillSignal = "SIGINT";
      TimeoutStopSec = 10;
    };
  };

  home.packages = [ pkgs.nextcloud-client ];
}
