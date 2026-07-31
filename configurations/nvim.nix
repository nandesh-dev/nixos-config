{
  self,
  inputs,
  ...
}:
{
  flake.homeConfigurations.nvim = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
    };

    modules = [
      self.homeModules.stylix
      self.homeModules.neovim
      {
        home.username = "nvim";
        home.homeDirectory = "/home/nvim";
        home.stateVersion = "26.05";
      }
    ];
  };
}
