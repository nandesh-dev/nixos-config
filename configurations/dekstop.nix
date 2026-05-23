{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.boot
      self.nixosModules.disko
      self.nixosModules.network
      self.nixosModules.preferences
      self.nixosModules.preservation
      (
        { pkgs, config, ... }:
        {
          users.users.nandesh = {
            isNormalUser = true;
            initialPassword = "1234";
            extraGroups = [ "wheel" ];
            packages = with pkgs; [
              tree
            ];
          };

          environment.systemPackages = with pkgs; [
            vim
            neovim
          ];

          programs.niri.enable = true;

          services.greetd = {
            enable = true;
            settings = {
              default_session = {
                command = "${config.programs.niri.package}/bin/niri-session";
                user = "nandesh";
              };
            };
          };

          systemd.user.services.niri.enableDefaultPath = false;

          services.openssh.enable = true;

          system.stateVersion = "25.11";
        }
      )
    ];
  };
}
