{ pkgs, ... }:
let
  option = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,credentials=/etc/samba/credentials,uid=1000,gid=100";
in
{
  environment.systemPackages = [ pkgs.cifs-utils ];

  environment.etc."samba/credentials" = {
    source = ./etc/samba/credentials;
    mode = "600";
  };

  fileSystems."/mnt/homelab/jellyfin" = {
    device = "//192.168.1.32/Jellyfin";
    fsType = "cifs";
    options = [ option ];
  };

  fileSystems."/mnt/homelab/photos" = {
    device = "//192.168.1.32/Photos";
    fsType = "cifs";
    options = [ option ];
  };

  fileSystems."/mnt/homelab/documents" = {
    device = "//192.168.1.32/Documents";
    fsType = "cifs";
    options = [ option ];
  };
}
