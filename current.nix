{
  hardware = import ./hardware/lenovo_ideapad_320.nix;
  system = [
    (import ./system/bluetooth/default/default.nix)
    (import ./system/boot_loader/default/default.nix)
    (import ./system/docker/default/default.nix)
    (import ./system/i3/default/default.nix)
    (import ./system/network_manager/default/default.nix)
    (import ./system/openssh/default/default.nix)
    (import ./system/pipewire/default/default.nix)
    (import ./system/samba/default/default.nix)
    (import ./system/tailscale/default/default.nix)
    (import ./system/tlp/default/default.nix)
    (import ./system/gc/default/default.nix)
  ];
  users = [
    {
      name = "root";
      description = "Admin";
      groups = [ ];
      home = [
        (import ./home/gh/default/default.nix)
        (import ./home/git/default/default.nix)
        (import ./home/neovim/default/default.nix)
      ];
      homeStateVersion = "18.09";
    }
    {
      name = "nandesh";
      description = "Nandesh";
      groups = [
        "wheel"
        "render"
        "video"
        "docker"
        "networkmanager"
        "audio"
        "sound"
      ];
      home = [
        (import ./home/android_studio/default/default.nix)
        (import ./home/flightgear/default/default.nix)
        (import ./home/obsidian/default/default.nix)
        (import ./home/blender/default/default.nix)
        (import ./home/discord/default/default.nix)
        (import ./home/brave/default/default.nix)
        (import ./home/firefox/default/default.nix)
        (import ./home/free_file_sync/default/default.nix)
        (import ./home/gh/default/default.nix)
        (import ./home/git/default/default.nix)
        (import ./home/htop/default/default.nix)
        (import ./home/i3/default/default.nix)
        (import ./home/dunst/default/default.nix)
        (import ./home/kitty/default/default.nix)
        (import ./home/nautilus/default/default.nix)
        (import ./home/neovim/default/default.nix)
        (import ./home/nerdfont/default/default.nix)
        (import ./home/postman/default/default.nix)
        (import ./home/yazi/default/default.nix)
        (import ./home/obs/default/default.nix)
        (import ./home/telegram/default/default.nix)
        (import ./home/prismlauncher/default/default.nix)
        (import ./home/ltspice/default/default.nix)
      ];
      homeStateVersion = "18.09";
    }
  ];
  systemStateVersion = "24.05";
}
