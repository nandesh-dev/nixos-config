{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden password manager
      { id = "nffaoalbilbmmfgbnbgppjihopabppdk"; } # video speed controller
      { id = "olhelnoplefjdmncknfphenjclimckaf"; } # catppuccin color theme
    ];
    commandLineArgs = [ "--force-dark-mode" ];
  };
}
