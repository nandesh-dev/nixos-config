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
      self.nixosModules.niri
      self.nixosModules.nix
      self.nixosModules.preferences
      self.nixosModules.preservation
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

          environment.pathsToLink = [
            "/share/applications"
            "/share/xdg-desktop-portal"
          ];

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            users.nandesh = {
              imports = [
                self.homeModules.niri
                self.homeModules.stylix
                {
                  home.username = "nandesh";
                  home.homeDirectory = "/home/nandesh";
                  home.stateVersion = "25.11";
                }
              ];
            };
          };
        }
      )
    ];
  };
}
