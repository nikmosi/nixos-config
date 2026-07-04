_: {
  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = "55.0";
    longitude = "82.9";
    temperature = {
      day = 5500;
      night = 3700;
    };
    settings = {
      gammastep = {
        brightness-day = 1.0;
        brightness-night = 0.9;
        transition = 1;
        adjustment-method = "wayland";
      };
    };
  };
}
