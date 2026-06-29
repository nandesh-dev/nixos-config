{ self, inputs, ... }:
{
  flake.homeModules.arduino =
    { pkgs, lib, ... }:
    {
      home.packages = [
        (pkgs.arduino-ide.overrideAttrs (old: {
          propagatedBuildInputs = (old.propagatedBuildInputs or [ ]) ++ [
            (pkgs.python3.withPackages (
              ps: with ps; [
                pyserial
                requests
              ]
            ))
          ];
          postFixup = (old.postFixup or "") + ''
            wrapProgram $out/bin/arduino-ide \
              --add-flags "--electronUserData=''${XDG_DATA_HOME:-$HOME/.local/share}/arduino"
          '';
        }))
      ];
    };
}
