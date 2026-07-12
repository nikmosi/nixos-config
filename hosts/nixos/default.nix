{
  # Host-specific NixOS settings for the desktop workstation
  nik = {
    location = {
      latitude = 55.0;
      longitude = 82.9;
    };
    networking = {
      uplinkInterface = "eno1";
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
        name = "DP-1";
        mode = "2560x1440@180.000";
        x = 0;
        y = 0;
        wallpaper = ../../assets/wallpapers/xiaomi.jpg;
      }
      {
        name = "DP-2";
        mode = "2560x1440@165.000";
        x = 2560;
        y = 0;
        wallpaper = ../../assets/wallpapers/philips.jpg;
      }
    ];
  };

  time.timeZone = "Asia/Novosibirsk";
}
