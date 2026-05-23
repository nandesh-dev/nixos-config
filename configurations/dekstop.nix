{
  self,
  inputs,
  ...
}:
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.boot
      self.nixosModules.disko
      self.nixosModules.network
      self.nixosModules.preferences
      self.nixosModules.preservation
      self.nixosModules.niri
      (
        { pkgs, config, ... }:
        {
          imports = [
            inputs.home-manager.nixosModules.default
          ];

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
            git
          ];

          services.openssh.enable = true;

          system.stateVersion = "25.11";

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
          };
        }
      )
    ];
  };

  flake.homeConfigurations.nandesh = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules.niri
      {
        home.username = "nandesh";
        home.homeDirectory = "/home/nandesh";
        home.stateVersion = "25.11";
      }
    ];
  };
}
