{ pkgs, config, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Kyiv";
  i18n.defaultLocale = "en_US.UTF-8";

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
