{ userDir }:
{
  groups = [ "docker" ];
  system =
    { pkgs, config, ... }:
    {
      virtualisation.docker = {
        enable = true;
      };
    };
  home =
    { pkgs, ... }:
    let
      containers = [
        {
          name = "photoprism";
          compose = (builtins.readFile ../containers/photoprism.yaml);
          volumes = [
            "photoprism"
            "database"
          ];
        }
        {
          name = "jellyfin";
          compose = (builtins.readFile ../containers/jellyfin.yaml);
          volumes = [
            "jellyfin"
            "sonarr"
            "radarr"
            "jackett"
            "qbittorrent/config"
            "qbittorrent/downloads"
          ];
        }
      ];
    in
    {
      home.file = builtins.listToAttrs (
        (map
          (volume: {
            name = "Docker/${volume}/.keep";
            value = {
              text = "";
            };
          })
          (
            builtins.concatLists (
              builtins.map (
                container: (builtins.map (volume: "${container.name}/${volume}") container.volumes)
              ) containers
            )
          )
        )
        ++ (map (container: {
          name = "Docker/${container.name}/docker-compose.yaml";
          value = {
            text = container.compose;
          };
        }) containers)
      );
    };
}
