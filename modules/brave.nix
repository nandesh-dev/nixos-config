{ }:
{
  home =
    { pkgs, ... }:
    {
      programs.chromium = {
        enable = true;
        package = pkgs.brave;
        extensions = [
          { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden password manager
          { id = "nffaoalbilbmmfgbnbgppjihopabppdk"; } # video speed controller
        ];
        commandLineArgs = [ "--force-dark-mode" ];
      };
    };
}
