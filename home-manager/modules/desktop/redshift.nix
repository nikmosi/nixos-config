{
  ...
}:

{
  services.redshift = {
    enable = true;
    tray = true;

    # "manual" provider allows setting latitude/longitude manually.
    # Change to "geoclue2" if you have the geoclue service enabled for auto-location.
    provider = "manual";
    latitude = "55.0";
    longitude = "82.9";

    temperature = {
      day = 5500;
      night = 3700;
    };

    settings = {
      redshift = {
        brightness-day = "1.0";
        brightness-night = "0.9";

        # Smooth transition between day and night
        transition = 1;

        # Adjustment method: randr is the most common for X11
        adjustment-method = "randr";
      };
    };
  };
}
