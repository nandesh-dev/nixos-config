{ pkgs, ... }:
{
  home.packages = [
    pkgs.neovim
    pkgs.stylua
    pkgs.nixfmt-rfc-style
    pkgs.stylelint
    pkgs.nodePackages.prettier
    pkgs.rustywind
    pkgs.rustfmt
    pkgs.buf
    pkgs.python312Packages.black
    pkgs.ripgrep
    pkgs.xclip
    pkgs.gcc14
  ];

  xdg.configFile."nvim" = {
    source = ./.config/nvim;
    recursive = true;
  };
}
