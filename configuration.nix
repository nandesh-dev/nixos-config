{ pkgs, ... }:

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

  users.users.yurii = {
    isNormalUser = true;
    initialPassword = "12345";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    neovim
  ];

  services.openssh.enable = true;

  system.stateVersion = "25.11";
}
