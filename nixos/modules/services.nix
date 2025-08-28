{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = [ "nik" ]; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };
  services.libinput = {
    enable = true;
    touchpad.accelProfile = "flat";
    mouse.accelProfile = "flat";
  };
  services.picom = {
    enable = true;
    settings = {
      backend = "glx";
      glx-copy-from-front = true;
      glx-swap-method = 2;
      glx-use-copysubbuffer-mesa = true;
      unredir-if-possible = false;
      vsync = true;
      xrender-sync = true;
      xrender-sync-fence = true;
    };
  };
}
