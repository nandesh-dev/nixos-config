{ self, inputs, ... }:
{
  flake.nixosModules.sops =
    { pkgs, config, ... }:
    {
      imports = [
        inputs.sops-nix.nixosModules.sops
      ];

      environment.systemPackages = [ pkgs.sops ];

      environment.sessionVariables = {
        SOPS_AGE_KEY_FILE = "/var/lib/sops/keys.txt";
      };

      sops = {
        age.keyFile = "/var/lib/sops/keys.txt";
        defaultSopsFile = ./../secrets.yaml;

        secrets = {
          wifiHome = {
            key = "wifi/home";
          };
          password = {
            neededForUsers = true;
          };
        };

        templates."wifi" = {
          content = ''
            [connection]
            id=Nandesh
            uuid=64a381c3-98ce-47ed-abb8-20229b367bcb
            type=wifi
            interface-name=wlp0s20f3

            [wifi]
            mode=infrastructure
            ssid=Nandesh

            [wifi-security]
            auth-alg=open
            key-mgmt=wpa-psk
            psk=${config.sops.placeholder.wifiHome}

            [ipv4]
            method=auto

            [ipv6]
            addr-gen-mode=default
            method=auto

            [proxy]
          '';
          path = "/etc/NetworkManager/system-connections/Nandesh.nmconnection";
        };
      };
    };

  flake.homeModules.sops =
    { config, ... }:
    {
      imports = [
        inputs.sops-nix.homeManagerModules.sops
      ];

      sops = {
        age.keyFile = "/var/lib/sops/keys.txt";
        defaultSopsFile = ../secrets.yaml;

        secrets = {
          ssh = {
            path = "${config.home.homeDirectory}/.ssh/id_ed25519";
            mode = "0600";
          };
        };
      };
    };

}
