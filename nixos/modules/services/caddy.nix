{
  services.caddy = {
    enable = true;
    virtualHosts."localhost:80".extraConfig = ''
      reverse_proxy http://localhost:8000
      tls internal
    '';

    virtualHosts."home.nikflora.ru".extraConfig = ''
      reverse_proxy http://localhost:8000
    '';

    virtualHosts."music.nikflora.ru" = {
      extraConfig = ''
        root * /var/lib/music-site
        file_server browse
      '';
    };

  };
}
