{ }:
{
  home =
    { pkgs, ... }:
    {
      programs.chromium = {
        enable = true;
        package = pkgs.brave;
        extensions = [
          { id = "ihennfdbghdiflogeancnalflhgmanop"; } # gruvbox theme
          { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden password manager
          { id = "nffaoalbilbmmfgbnbgppjihopabppdk"; } # video speed controller
          { id = "nlgphodeccebbcnkgmokeegopgpnjfkc"; } # super dark mode
        ];
        commandLineArgs = [ "--force-dark-mode" ];
      };
    };
}
