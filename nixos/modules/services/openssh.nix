{
  config,
  lib,
  ...
}:
{
  services.openssh = {
    enable = true;
    ports = [ config.nik.services.openssh.port ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "nik" ];
      UseDns = false;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };

  services.endlessh = lib.mkIf config.nik.services.endlessh.enable {
    enable = true;
    port = 22;
    openFirewall = true;
  };
}
