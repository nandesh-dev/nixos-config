{ }:
{
  home =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.zoxide ];
      home.file.".bashrc".text = ''eval "$(zoxide init bash)"'';
    };
}
