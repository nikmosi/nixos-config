{
  services.caddy = {
    enable = true;
    virtualHosts."craft.nikflora.ru".extraConfig = ''
      reverse_proxy http://localhost:8000
    '';
  };
}
