{
  # Host-specific NixOS settings for the laptop (AMD Ryzen 5 3500U)
  nik = {
    hardware = {
      gpu = "amd";
      printer = false;
    };
    virtualization = {
      docker.storageDriver = "overlay2";
      virtualbox.enable = false;
    };
    services = {
      endlessh.enable = false;
      openssh.port = 63544;
    };

    location = {
      latitude = 55.0;
      longitude = 82.9;
    };
    networking = {
      uplinkInterface = "wlp2s0";
      extraHosts = ''
        192.168.3.3 home
        127.0.0.1 rustek.localhost
        127.0.0.1 auth.rustek.localhost
      '';
    };
    docker.dns = [
      "8.8.8.8"
      "1.1.1.1"
    ];
    monitors = [
      {
        name = "eDP-1";
        mode = "1920x1080@60.000";
        x = 0;
        y = 0;
        wallpaper = ../../assets/wallpapers/xiaomi.jpg;
      }
    ];
  };

  time.timeZone = "Asia/Novosibirsk";
}
