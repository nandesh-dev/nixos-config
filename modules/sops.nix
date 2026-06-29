{ self, inputs, ... }:
{
  flake.nixosModules.sops =
    { pkgs, config, ... }:
    {
      imports = [
        inputs.sops-nix.nixosModules.sops
      ];

      environment.sessionVariables = {
        SOPS_AGE_KEY_FILE = "/var/lib/sops/keys.txt";
      };

      sops = {
        age.keyFile = "/var/lib/sops/keys.txt";
        defaultSopsFile = ./../secrets.yaml;

        secrets.github = {
          owner = config.users.users.nandesh.name;
        };

        templates."gh-hosts" = {
          content = ''
            github.com:
              users:
                nandesh-dev:
                  oauth_token: ${config.sops.placeholder.github}
              git_protocol: https
              oauth_token: ${config.sops.placeholder.github}
              user: nandesh-dev
          '';
          owner = config.users.users.nandesh.name;
          path = "/home/${config.users.users.nandesh.name}/.config/gh/hosts.yml";
        };
      };
    };
}
