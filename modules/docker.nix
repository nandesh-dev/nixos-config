{ username }:
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
    { pkgs, current, ... }:
    let
      containers = [
        {
          name = "photoprism";
          compose = ''
            services:
              photoprism:
                image: photoprism/photoprism:latest
                # restart: unless-stopped
                stop_grace_period: 10s
                depends_on:
                  - mariadb
                security_opt:
                  - seccomp:unconfined
                  - apparmor:unconfined
                ports:
                  - "2342:2342"
                environment:
                  PHOTOPRISM_ADMIN_USER: "admin"                 # admin login username
                  PHOTOPRISM_ADMIN_PASSWORD: "insecure"          # initial admin password (8-72 characters)
                  PHOTOPRISM_AUTH_MODE: "password"               # authentication mode (public, password)
                  PHOTOPRISM_SITE_URL: "http://localhost:2342/"  # server URL in the format "http(s)://domain.name(:port)/(path)"
                  PHOTOPRISM_DISABLE_TLS: "false"                # disables HTTPS/TLS even if the site URL starts with https:// and a certificate is available
                  PHOTOPRISM_DEFAULT_TLS: "true"                 # defaults to a self-signed HTTPS/TLS certificate if no other certificate is available
                  PHOTOPRISM_ORIGINALS_LIMIT: 5000               # file size limit for originals in MB (increase for high-res video)
                  PHOTOPRISM_HTTP_COMPRESSION: "gzip"            # improves transfer speed and bandwidth utilization (none or gzip)
                  PHOTOPRISM_LOG_LEVEL: "info"                   # log level: trace, debug, info, warning, error, fatal, or panic
                  PHOTOPRISM_READONLY: "false"                   # do not modify originals directory (reduced functionality)
                  PHOTOPRISM_EXPERIMENTAL: "false"               # enables experimental features
                  PHOTOPRISM_DISABLE_CHOWN: "false"              # disables updating storage permissions via chmod and chown on startup
                  PHOTOPRISM_DISABLE_WEBDAV: "false"             # disables built-in WebDAV server
                  PHOTOPRISM_DISABLE_SETTINGS: "false"           # disables settings UI and API
                  PHOTOPRISM_DISABLE_TENSORFLOW: "false"         # disables all features depending on TensorFlow
                  PHOTOPRISM_DISABLE_FACES: "false"              # disables face detection and recognition (requires TensorFlow)
                  PHOTOPRISM_DISABLE_CLASSIFICATION: "false"     # disables image classification (requires TensorFlow)
                  PHOTOPRISM_DISABLE_VECTORS: "false"            # disables vector graphics support
                  PHOTOPRISM_DISABLE_RAW: "false"                # disables indexing and conversion of RAW images
                  PHOTOPRISM_RAW_PRESETS: "false"                # enables applying user presets when converting RAW images (reduces performance)
                  PHOTOPRISM_SIDECAR_YAML: "true"                # creates YAML sidecar files to back up picture metadata
                  PHOTOPRISM_BACKUP_ALBUMS: "true"               # creates YAML files to back up album metadata
                  PHOTOPRISM_BACKUP_DATABASE: "true"             # creates regular backups based on the configured schedule
                  PHOTOPRISM_BACKUP_SCHEDULE: "daily"            # backup SCHEDULE in cron format (e.g. "0 12 * * *" for daily at noon) or at a random time (daily, weekly)
                  PHOTOPRISM_INDEX_SCHEDULE: ""                  # indexing SCHEDULE in cron format (e.g. "@every 3h" for every 3 hours; "" to disable)
                  PHOTOPRISM_AUTO_INDEX: 300                     # delay before automatically indexing files in SECONDS when uploading via WebDAV (-1 to disable)
                  PHOTOPRISM_AUTO_IMPORT: -1                     # delay before automatically importing files in SECONDS when uploading via WebDAV (-1 to disable)
                  PHOTOPRISM_DETECT_NSFW: "false"                # automatically flags photos as private that MAY be offensive (requires TensorFlow)
                  PHOTOPRISM_UPLOAD_NSFW: "true"                 # allows uploads that MAY be offensive (no effect without TensorFlow)
                  # PHOTOPRISM_DATABASE_DRIVER: "sqlite"         # SQLite is an embedded database that does not require a separate database server
                  PHOTOPRISM_DATABASE_DRIVER: "mysql"            # MariaDB 10.5.12+ (MySQL successor) offers significantly better performance compared to SQLite
                  PHOTOPRISM_DATABASE_SERVER: "mariadb:3306"     # MariaDB database server (hostname:port)
                  PHOTOPRISM_DATABASE_NAME: "photoprism"         # MariaDB database schema name
                  PHOTOPRISM_DATABASE_USER: "photoprism"         # MariaDB database user name
                  PHOTOPRISM_DATABASE_PASSWORD: "insecure"       # MariaDB database user password
                  PHOTOPRISM_SITE_CAPTION: "AI-Powered Photos App"
                  PHOTOPRISM_SITE_DESCRIPTION: ""                # meta site description
                  PHOTOPRISM_SITE_AUTHOR: ""                     # meta site author
                  ## Video Transcoding (https://docs.photoprism.app/getting-started/advanced/transcoding/):
                  # PHOTOPRISM_FFMPEG_ENCODER: "software"        # H.264/AVC encoder (software, intel, nvidia, apple, raspberry, or vaapi)
                  # PHOTOPRISM_FFMPEG_SIZE: "1920"               # video size limit in pixels (720-7680) (default: 3840)
                  # PHOTOPRISM_FFMPEG_BITRATE: "32"              # video bitrate limit in Mbit/s (default: 50)
                  ## Run/install on first startup (options: update https gpu ffmpeg tensorflow davfs clitools clean):
                  # PHOTOPRISM_INIT: "https gpu tensorflow"
                  PHOTOPRISM_UID: 1000
                  PHOTOPRISM_GID: 100
                  # PHOTOPRISM_UMASK: 0000
                user: "1000:100"
                working_dir: "/photoprism" # do not change or remove
                volumes:
                  - "/home/${username}/Pictures:/photoprism/originals"               # Original media files (DO NOT REMOVE)
                  - "./photoprism:/photoprism/storage"                  # *Writable* storage folder for cache, database, and sidecar files (DO NOT REMOVE)

              ## MariaDB Database Server (recommended)
              mariadb:
                image: mariadb:11
                user: "1000:100"
                restart: unless-stopped
                stop_grace_period: 5s
                security_opt: # see https://github.com/MariaDB/mariadb-docker/issues/434#issuecomment-1136151239
                  - seccomp:unconfined
                  - apparmor:unconfined
                command: --innodb-buffer-pool-size=512M --transaction-isolation=READ-COMMITTED --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci --max-connections=512 --innodb-rollback-on-timeout=OFF --innodb-lock-wait-timeout=120
                volumes:
                  - "./database:/var/lib/mysql" 
                environment:
                  MARIADB_AUTO_UPGRADE: "1"
                  MARIADB_INITDB_SKIP_TZINFO: "1"
                  MARIADB_DATABASE: "photoprism"
                  MARIADB_USER: "photoprism"
                  MARIADB_PASSWORD: "insecure"
                  MARIADB_ROOT_PASSWORD: "insecure"
          '';
          volumes = [
            "photoprism"
            "database"
          ];
        }
        {
          name = "jellyfin";
          compose = ''
            ---
            services:
              jellyfin:
                image: lscr.io/linuxserver/jellyfin:latest
                container_name: jellyfin
                environment:
                  - PUID=1000
                  - PGID=100
                  - TZ=Etc/UTC
                volumes:
                  - ./jellyfin:/config
                  - /home/${username}/Jellyfin:/media
                ports:
                  - 8000:8096
                networks:
                  - jellyfin
                restart: unless-stopped
              
              sonarr:
                image: lscr.io/linuxserver/sonarr:latest
                container_name: sonarr
                environment:
                  - PUID=1000
                  - PGID=100
                  - TZ=Etc/UTC
                volumes:
                  - ./sonarr:/config
                  - downloads:/downloads
                  - /home/${username}/Jellyfin:/media
                ports:
                  - 8001:8989
                networks:
                  - jellyfin
                restart: unless-stopped

              radarr:
                image: lscr.io/linuxserver/radarr:latest
                container_name: radarr
                environment:
                  - PUID=1000
                  - PGID=100
                  - TZ=Etc/UTC
                volumes:
                  - ./radarr:/config
                  - downloads:/downloads
                  - /home/${username}/Jellyfin:/media
                ports:
                  - 8002:7878
                networks:
                  - jellyfin
                restart: unless-stopped

              jackett:
                image: lscr.io/linuxserver/jackett:latest
                container_name: jackett
                environment:
                  - PUID=1000
                  - PGID=100
                  - TZ=Etc/UTC
                  - AUTO_UPDATE=true
                volumes:
                  - ./jackett:/config
                ports:
                  - 8003:9117
                networks:
                  - jellyfin
                restart: unless-stopped

              qbittorrent:
                image: lscr.io/linuxserver/qbittorrent:latest
                container_name: qbittorrent
                environment:
                  - PUID=1000
                  - PGID=100
                  - TZ=Etc/UTC
                  - WEBUI_PORT=8004
                  - TORRENTING_PORT=6881
                volumes:
                  - ./qbittorrent:/config
                  - downloads:/downloads
                ports:
                  - 8004:8004
                  - 6881:6881
                  - 6881:6881/udp
                networks:
                  - jellyfin
                restart: unless-stopped

            networks:
              jellyfin:
                driver: bridge

            volumes:
              downloads:
          '';
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
