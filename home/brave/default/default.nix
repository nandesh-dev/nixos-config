{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden password manager
      { id = "nffaoalbilbmmfgbnbgppjihopabppdk"; } # video speed controller
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
      { id = "dlcadbmcfambdjhecipbnolmjchgnode"; } # everforest color theme
    ];
    commandLineArgs = [ "--force-dark-mode" ];
  };
}
