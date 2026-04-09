{
  services.openssh = {
    enable = true;
    ports = [ 22000 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "nik" ]; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = false;
      X11Forwarding = false;
      PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  services.endlessh = {
    enable = true;
    port = 22;
    openFirewall = true;
  };
}
