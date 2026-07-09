{ inputs, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = {
      # ── Shell ──────────────────────────────────────────────────────────
      shell = {
        font_family = "JetBrains Mono, Symbols Nerd Font, Noto Sans CJK JP";
        launch_apps_as_systemd_services = true;
        polkit_agent = false;
        setup_wizard_enabled = false;
        middle_click_opens_widget_settings = true;
        clipboard_enabled = true;
        clipboard_history_max_entries = 100;
      };

      shell.animation = {
        enabled = true;
        speed = 1.0;
      };

      shell.shadow = {
        direction = "down";
        alpha = 0.55;
      };

      shell.panel = {
        transparency_mode = "solid";
        borders = true;
        shadow = true;
        launcher_placement = "centered";
        control_center_placement = "attached";
        session_placement = "attached";
      };

      # ── Theme ──────────────────────────────────────────────────────────
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Tokyo-Night";
      };

      # ── Bar ────────────────────────────────────────────────────────────
      bar.main = {
        position = "top";
        thickness = 48;
        background_opacity = 1.0;
        radius = 12;
        reserve_space = true;
        margin_ends = 0;
        margin_edge = 0;
        padding = 6;
        widget_spacing = 8;
        scale = 1.0;
        shadow = true;

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
          "sysmon-cpu"
          "sysmon-ram"
          "sysmon-temp"
          "network"
          "caffeine"
          "lock_keys"
          "volume"
          "media"
          "keyboard_layout"
          "session"
        ];
      };

      # ── Widgets ────────────────────────────────────────────────────────
      widget = {
        # Workspace switcher — display = "name" показывает имена из niri
        # (японские номера 一–十 + именованные workspace)
        workspaces = {
          display = "name";
          minimal = false;
          max_label_chars = 2;
          pill_scale = 1.0;
          active_pill_size = 2.2;
          inactive_pill_size = 1.0;
          focused_color = "primary";
          occupied_color = "secondary";
          empty_color = "surface_variant";
          focused_output_only = false;
        };

        active_window = {
          max_length = 260;
          display = "icon_and_text";
          title_scroll = "on_hover";
          show_empty_label = true;
        };

        clock = {
          format = "{:%H:%M}";
          tooltip_format = "{:%A, %B %d, %Y}";
        };

        "sysmon-cpu" = {
          type = "sysmon";
          stat = "cpu_usage";
          display = "gauge";
          show_label = true;
        };

        "sysmon-ram" = {
          type = "sysmon";
          stat = "ram_pct";
          display = "gauge";
          show_label = true;
        };

        "sysmon-temp" = {
          type = "sysmon";
          stat = "cpu_temp";
          display = "text";
          show_label = true;
        };

        volume = {
          show_label = true;
          scroll_step = 5;
          device = "output";
        };

        media = {
          max_length = 220;
          hide_when_no_media = true;
          title_scroll = "on_hover";
        };

        keyboard_layout = {
          display = "short";
          show_icon = true;
          show_label = true;
          hide_when_single_layout = false;
        };

        lock_keys = {
          show_caps_lock = true;
          show_num_lock = true;
          show_scroll_lock = false;
          hide_when_off = true;
          display = "short";
        };

        caffeine = { };

        network = {
          show_label = true;
        };

        tray = {
          drawer = false;
          drawer_columns = 3;
          match_adjacent_spacing = false;
        };

        weather = {
          max_length = 160;
          show_condition = true;
          show_temperature = true;
        };

        session = {
          glyph = "shutdown";
        };
      };

      # ── Location ───────────────────────────────────────────────────────
      location = {
        latitude = 55.0;
        longitude = 82.9;
      };

      # ── Night Light ────────────────────────────────────────────────────
      nightlight = {
        enabled = true;
        force = false;
        temperature_day = 5500;
        temperature_night = 3700;
      };

      # ── Weather ────────────────────────────────────────────────────────
      weather = {
        enabled = true;
        refresh_minutes = 10;
        unit = "metric";
        effects = false;
      };

      # ── Notifications ──────────────────────────────────────────────────
      notification = {
        enable_daemon = true;
        show_app_name = true;
        show_actions = true;
        layer = "top";
        scale = 1.0;
        background_opacity = 0.97;
      };

      # ── OSD ────────────────────────────────────────────────────────────
      osd = {
        position = "top_right";
        orientation = "horizontal";
        scale = 1.0;
        background_opacity = 0.97;
      };

      # ── Lock Screen ────────────────────────────────────────────────────
      lockscreen = {
        enabled = true;
        blurred_desktop = false;
        blur_intensity = 0.5;
        tint_intensity = 0.3;
      };

      # ── Dock ───────────────────────────────────────────────────────────
      dock = {
        enabled = false;
      };
    };
  };
}
