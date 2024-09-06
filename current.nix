{
  username = "nandesh";
  usernameDescription = "Nandesh";
  machine = import ./machines/lenovo-laptop.nix;
  modules = [
    ((import ./modules/i3.nix) { })
    ((import ./modules/neovim.nix) {
      enabledUnits = [
        "options"
        "tree"
        "gruvbox"
        "conform"
        "harpoon"
        "lualine"
        "leap"
        "surround"
        "treesitter"
        "cmp"
        "stay-centered"
        "highlight-colors"
        "undotree"
        "telescope"
        "tailwind-fold"
      ];
    })
    ((import ./modules/git.nix) { })
    ((import ./modules/nerdfont.nix) { })
    ((import ./modules/brave.nix) { })
    ((import ./modules/kitty.nix) { })
    ((import ./modules/zoxide.nix) { })
    ((import ./modules/dunst.nix) { })
    ((import ./modules/yazi.nix) { })
    ((import ./modules/bootloader.nix) { })
    ((import ./modules/networkmanager.nix) { })
    ((import ./modules/blueman.nix) { })
    ((import ./modules/pipewire.nix) { })
    ((import ./modules/freefilesync.nix) { })
    ((import ./modules/go.nix) { })
    ((import ./modules/nautilus.nix) { })
    ((import ./modules/docker.nix) { userDir = "/home/nandesh"; })
    ((import ./modules/htop.nix) { })
  ];
}