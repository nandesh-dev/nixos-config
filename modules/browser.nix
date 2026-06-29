{ self, inputs, ... }:
{
  flake.homeModules.brave =
    { pkgs, lib, ... }:
    {
      programs.chromium = {
        enable = true;
        package = pkgs.brave;
        extensions = [
          { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden password manager
          { id = "dlcadbmcfambdjhecipbnolmjchgnode"; } # everforest color theme
        ];
        commandLineArgs = [ "--force-dark-mode" ];
      };
    };
}
