{
  inputs,
  config,
  lib,
  ...
}:
let
  p = config.dotfiles.palette;
in
{
  imports = [ inputs.noctalia.homeModules.default ];

  config = lib.mkIf config.local.desktop.noctalia.enable {

    programs.noctalia = {
      customPalettes = {
        "Catppuccin-Macchiato" = {
          dark = {
            mPrimary = p.mauve;
            mOnPrimary = p.crust;
            mSecondary = p.peach;
            mOnSecondary = p.crust;
            mTertiary = p.teal;
            mOnTertiary = p.crust;
            mError = p.red;
            mOnError = p.crust;
            mSurface = p.base;
            mOnSurface = p.text;
            mSurfaceVariant = p.surface0;
            mOnSurfaceVariant = p.subtext1;
            mOutline = p.overlay0;
            mShadow = p.crust;
            mHover = p.teal;
            mOnHover = p.crust;
            terminal = {
              normal = {
                black = p.surface1;
                inherit (p) red;
                inherit (p) green;
                inherit (p) yellow;
                inherit (p) blue;
                magenta = p.pink;
                cyan = p.teal;
                white = p.subtext1;
              };
              bright = {
                black = p.surface2;
                inherit (p) red;
                inherit (p) green;
                inherit (p) yellow;
                inherit (p) blue;
                magenta = p.pink;
                cyan = p.teal;
                white = p.subtext0;
              };
              foreground = p.text;
              background = p.base;
              cursor = p.rosewater;
              cursorText = p.base;
              selectionFg = p.text;
              selectionBg = p.surface2;
            };
          };
        };
      };
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
          corner_radius_scale = 1.2;
        };

        shell.animation = {
          enabled = true;
          speed = 1.0;
        };

        shell.shadow = {
          direction = "down";
          alpha = 0.4;
        };

        shell.panel = {
          transparency_mode = "soft";
          borders = true;
          shadow = true;
          launcher_placement = "floating";
          launcher_position = "center";
          control_center_placement = "attached";
          session_placement = "attached";
        };

        # ── Theme ──────────────────────────────────────────────────────────
        theme = {
          mode = "dark";
          source = "custom";
          custom_palette = "Catppuccin-Macchiato";
        };

        # ── Bar ────────────────────────────────────────────────────────────
        bar.main = {
          position = "top";
          thickness = 54;
          background_opacity = 0.98;
          radius = 0;
          reserve_space = true;
          margin_ends = 0;
          margin_edge = 0;
          padding = 10;
          widget_spacing = 6;
          scale = 1.3;
          shadow = true;
          border = "outline";
          border_width = 1.0;
          concave_edge_corners = false;
          hover_highlight = true;
          font_weight = 500;

          capsule = true;
          capsule_fill = "surface_variant";
          capsule_opacity = 0.8;
          capsule_radius = 8.0;

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
          # Цвета — Catppuccin Macchiato (явные hex, не color roles)
          workspaces = {
            display = "name";
            minimal = false;
            max_label_chars = 2;
            pill_scale = 1.0;
            active_pill_size = 2.2;
            inactive_pill_size = 1.0;
            focused_color = "#c6a0f6";
            occupied_color = "#8aadf4";
            empty_color = "#494d64";
            focused_output_only = false;
            hide_when_empty = false;
            labels_only_when_occupied = false;
          };

          active_window = {
            max_length = 240;
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
            highlight_color = "#ed8796";
            label_min_width = 32;
          };

          "sysmon-ram" = {
            type = "sysmon";
            stat = "ram_pct";
            display = "gauge";
            show_label = true;
            highlight_color = "#eed49f";
            label_min_width = 32;
          };

          "sysmon-temp" = {
            type = "sysmon";
            stat = "cpu_temp";
            display = "text";
            show_label = true;
            highlight_color = "#f5a97f";
            label_min_width = 40;
          };

          volume = {
            show_label = true;
            scroll_step = 5;
            device = "output";
          };

          media = {
            max_length = 200;
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
            max_length = 140;
            show_condition = true;
            show_temperature = true;
          };

          session = {
            glyph = "shutdown";
          };
        };

        # ── Location ───────────────────────────────────────────────────────
        location = {
          latitude = config.dotfiles.location.latitude;
          longitude = config.dotfiles.location.longitude;
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
          background_opacity = 0.90;
        };

        # ── OSD ────────────────────────────────────────────────────────────
        osd = {
          position = "top_right";
          orientation = "horizontal";
          scale = 1.0;
          background_opacity = 0.90;
          kinds.keyboard_layout = false;
        };

        # ── Lock Screen ────────────────────────────────────────────────────
        lockscreen = {
          enabled = true;
          blurred_desktop = true;
          blur_intensity = 0.7;
          tint_intensity = 0.2;
        };

        # ── Dock ───────────────────────────────────────────────────────────
        dock = {
          enabled = false;
        };
      };
    };
  };
}
