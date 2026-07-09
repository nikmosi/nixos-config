{ inputs, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = {
      shell = {
        font_family = "JetBrains Mono, Symbols Nerd Font, Noto Sans CJK JP";
        launch_apps_as_systemd_services = true;
        polkit_agent = false;
        setup_wizard_enabled = false;
      };

      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Tokyo-Night";
      };

      bar = {
        order = [ "main" ];
      };

      bar.main = {
        position = "top";
        thickness = 48;
        background_opacity = 1.0;
        reserve_space = true;
        margin_ends = 0;
        margin_edge = 0;
        padding = 6;
        widget_spacing = 8;
        capsule = true;
        capsule_fill = "surface_variant";
        capsule_opacity = 1.0;
        capsule_radius = 6.0;

        start = [
          "workspaces"
          "active_window"
        ];
        center = [ "clock" ];
        end = [
          "tray"
          "weather"
          "sysmon"
          "network"
          "caffeine"
          "lock_keys"
          "volume"
          "media"
          "keyboard_layout"
          "session"
        ];
      };

      widget = {
        workspaces = {
          display = "name";
          minimal = false;
          max_label_chars = 2;
        };

        active_window = {
          max_length = 50;
        };

        clock = {
          format = "{:%H:%M}";
          tooltip_format = "{:%A, %B %d, %Y}";
        };

        sysmon = {
          show_cpu = true;
          show_memory = true;
          show_temperature = true;
        };

        volume = { };

        media = { };

        keyboard_layout = { };

        lock_keys = {
          numlock = true;
          capslock = true;
        };

        caffeine = { };

        network = { };

        tray = {
          spacing = 8;
        };

        weather = { };

        session = { };
      };

      location = {
        latitude = 55.0;
        longitude = 82.9;
      };

      nightlight = {
        enabled = true;
        temperature_day = 5500;
        temperature_night = 3700;
      };

      weather = {
        enabled = true;
        refresh_minutes = 10;
        unit = "metric";
        effects = false;
      };

      notification = {
        enable_daemon = true;
      };

      dock = {
        enabled = false;
      };
    };
  };
}
