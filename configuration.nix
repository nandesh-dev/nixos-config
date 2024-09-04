{ lib, ... }:
let
  current = import ./current.nix;
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
  modules = current.modules;
  user-groups =
    let
      getGroups = module: module.groups;
      filterEmptyGroups = module: builtins.hasAttr "groups" module;
    in
    builtins.concatMap getGroups (builtins.filter filterEmptyGroups modules);
  home-imports =
    let
      getHome = module: module.home;
      filterEmptyHome = module: builtins.hasAttr "home" module;
    in
    map getHome (builtins.filter filterEmptyHome modules);
  system-imports =
    let
      getSystem = module: module.system;
      filterEmptySystem = module: builtins.hasAttr "system" module;
    in
    map getSystem (builtins.filter filterEmptySystem modules);
in
{
  imports = [
    (import "${home-manager}/nixos")
    current.machine
  ] ++ system-imports;

  users.users = {
    root = {
      description = lib.mkForce "Admin";
    };
    "${current.username}" = {
      isNormalUser = true;
      description = current.usernameDescription;
      extraGroups = [ "wheel" ] ++ user-groups;
    };
  };

  home-manager.backupFileExtension = "bk";
  home-manager.users = {
    root = {
      imports = home-imports;
      home.stateVersion = "18.09";
    };
    "${current.username}" = {
      imports = home-imports;
      home.stateVersion = "18.09";
    };
  };

  system.stateVersion = "24.05";
}
