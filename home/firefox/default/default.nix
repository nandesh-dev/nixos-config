{ ... }:
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        "middlemouse.paste" = false;
      };
    };
  };
}
