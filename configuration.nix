{ ... }:
let
  current = import ./current.nix;
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
    current.hardware
  ] ++ current.system;

  users.users = builtins.listToAttrs (
    map (user: {
      name = user.name;
      value = {
        isNormalUser = true;
        description = user.description;
        extraGroups = user.groups;
      };
    }) (builtins.filter (user: user.name != "root") current.users)
  );

  home-manager.backupFileExtension = "bkp";

  home-manager.users = builtins.listToAttrs (
    map (user: {
      name = user.name;
      value = {
        imports = user.home;
        home.stateVersion = user.homeStateVersion;
      };
    }) current.users
  );

  system.stateVersion = current.systemStateVersion;
}
