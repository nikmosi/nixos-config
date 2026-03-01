{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    php
  ];

  services.phpfpm.pools.music_site = {
    user = "caddy";
    group = "caddy"; # Права, чтобы Caddy мог читать файлы
    settings = {
      "listen.owner" = "caddy";
      "listen.group" = "caddy";
      "pm" = "dynamic";
      "pm.max_children" = 5;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 1;
      "pm.max_spare_servers" = 3;
    };
  };

  services.caddy = {
    enable = true;
    virtualHosts = {
      "localhost:80".extraConfig = ''
        reverse_proxy http://localhost:8000
        tls internal
      '';

      "home.nikflora.ru".extraConfig = ''
        reverse_proxy http://localhost:8000
      '';

      "jelly.4041.su".extraConfig = ''
        reverse_proxy http://localhost:8096
      '';
    };

    # virtualHosts."music.nikflora.ru" = {
    #   extraConfig = ''
    #     root * /var/lib/music-site
    #     file_server browse
    #   '';
    # };

  };
}
