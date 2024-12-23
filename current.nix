let
  username = "nandesh";
  usernameDescription = "Nandesh";
in
{
  username = username;
  usernameDescription = usernameDescription;
  machine = import ./machines/lenovo-laptop.nix;
  modules = [
    ((import ./modules/i3.nix) { usernameDescription = usernameDescription; })
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
        "indent-blankline"
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
    ((import ./modules/docker.nix) { username = username; })
    ((import ./modules/htop.nix) { })
    ((import ./modules/android_studio.nix) { })
    ((import ./modules/openssh.nix) { })
    ((import ./modules/postman.nix) { })
    ((import ./modules/blender.nix) { })
    ((import ./modules/tlp.nix) { })
    ((import ./modules/samba.nix) { })
  ];
}
