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
      self.nixosModules.bluetooth
      self.nixosModules.power
      self.nixosModules.nautilus
      self.nixosModules.sops
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
          };

          environment.systemPackages = with pkgs; [
            nano
            git
          ];

          system.stateVersion = "26.05";

          home-manager = {
            users.nandesh = {
              imports = [
                self.homeModules.kitty
                self.homeModules.niri
                self.homeModules.stylix
                self.homeModules.brave
                self.homeModules.neovim
                self.homeModules.noctalia
                self.homeModules.gtk
                self.homeModules.arduino
                self.homeModules.git
                {
                  home.username = "nandesh";
                  home.homeDirectory = "/home/nandesh";
                  home.stateVersion = "26.05";
                }
              ];
            };
          };
        }
      )
    ];
  };
}
