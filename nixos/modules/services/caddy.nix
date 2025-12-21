{
  services.caddy = {
    enable = true;
    virtualHosts."localhost:80".extraConfig = ''
      reverse_proxy http://localhost:8000
      tls internal
    '';

    virtualHosts."craft.nikflora.ru".extraConfig = ''
      reverse_proxy http://localhost:8000
    '';

  };
}
