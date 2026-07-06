{ pkgs, ... }:
let
  # Tokyo Night palette (hardcoded — не stylix)
  c = {
    bg = "#1a1b26";
    bgHighlight = "#1f2335";
    bgStatusline = "#1f2335";
    fg = "#c0caf5";
    blue = "#7aa2f7";
    green = "#9ece6a";
    yellow = "#e0af68";
    red = "#f7768e";
    cyan = "#7dcfff";
    purple = "#bb9af7";
    comment = "#565f89";
  };

  wallpaperXiaomi = ../../../assets/wallpapers/xiaomi.jpg;
  wallpaperPhilips = ../../../assets/wallpapers/philips.jpg;
in
{
  wayland.windowManager.niri = {
    enable = true;
    package = pkgs.niri;

    settings = {
      # ── Input ──────────────────────────────────────────────
      input = {
        keyboard = {
          xkb = {
            layout = "us,ru";
            options = "grp:alt_shift_toggle";
          };
          numlock = [ ];
        };
        mouse = {
          accel-profile = "flat";
        };
        touchpad = {
          accel-profile = "flat";
        };
      };

      # ── Outputs ────────────────────────────────────────────
      output = [
        {
          _args = [ "DP-1" ];
          mode = "2560x1440@180.000";
          variable-refresh-rate = [ ];
          position._props = {
            x = 0;
            y = 0;
          };
        }
        {
          _args = [ "DP-2" ];
          mode = "2560x1440@165.000";
          position._props = {
            x = 2560;
            y = 0;
          };
        }
      ];

      # ── Named workspaces ───────────────────────────────────
      # DP-1 (left): 一-六 + web + minecraft
      workspace = [
        {
          _args = [ "一" ];
          open-on-output = "DP-1";
        }
        {
          _args = [ "二" ];
          open-on-output = "DP-1";
        }
        {
          _args = [ "三" ];
          open-on-output = "DP-1";
        }
        {
          _args = [ "四" ];
          open-on-output = "DP-1";
        }
        {
          _args = [ "五" ];
          open-on-output = "DP-1";
        }
        {
          _args = [ "web" ];
          open-on-output = "DP-1";
        }
        {
          _args = [ "minecraft" ];
          open-on-output = "DP-1";
        }
        # DP-2 (right): 七-十二 + app-specific
        {
          _args = [ "六" ];
          open-on-output = "DP-2";
        }
        {
          _args = [ "七" ];
          open-on-output = "DP-2";
        }
        {
          _args = [ "八" ];
          open-on-output = "DP-2";
        }
        {
          _args = [ "九" ];
          open-on-output = "DP-2";
        }
        {
          _args = [ "十" ];
          open-on-output = "DP-2";
        }
        {
          _args = [ "discord" ];
          open-on-output = "DP-2";
        }
        {
          _args = [ "telegram" ];
          open-on-output = "DP-2";
        }
        {
          _args = [ "chatterino" ];
          open-on-output = "DP-2";
        }
        {
          _args = [ "localsend" ];
          open-on-output = "DP-2";
        }
        {
          _args = [ "superprod" ];
          open-on-output = "DP-2";
        }
        {
          _args = [ "easyeffects" ];
          open-on-output = "DP-2";
        }
      ];

      # ── Layout ─────────────────────────────────────────────
      layout = {
        gaps = 8;
        empty-workspace-above-first = false;

        focus-ring = {
          width = 2;
          active-color = c.blue;
          inactive-color = c.comment;
          urgent-color = c.red;
        };

        border = {
          off = [ ];
        };

        shadow = {
          on = [ ];
          softness = 30;
          spread = 5;
          offset._props = {
            x = 0;
            y = 5;
          };
          color = "#0007";
        };

        default-column-width._children = [ { proportion = 0.5; } ];

        center-focused-column = "on-overflow";

        # Tab indicator для tabbed column display
        tab-indicator = {
          place-within-column = [ ];
          width = 8;
          position = "left";
          gap = 10;
        };

        # Отступы от waybar (40px сверху)
        struts = {
          left = 0;
          right = 0;
          top = 0;
          bottom = 0;
        };
      };

      # ── Misc top-level ─────────────────────────────────────
      prefer-no-csd = [ ];

      screenshot-path = "~/Pictures/screenshots/%F_%T.png";

      # ── Environment (best practice) ────────────────────────
      environment = {
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        XDG_CURRENT_DESKTOP = "niri:GNOME";
        MOZ_ENABLE_WAYLAND = "1";
        QT_QPA_PLATFORM = "wayland";
        DISPLAY = ":0"; # для xwayland-satellite
      };

      # ── Cursor ─────────────────────────────────────────────
      cursor = {
        xcursor-theme = "Numix-Cursor-Light";
        xcursor-size = 24;
        hide-when-typing = [ ];
      };

      # ── Hotkey overlay ──────────────────────────────────────
      hotkey-overlay = {
        skip-at-startup = [ ];
      };

      # ── Layer rules ────────────────────────────────────────
      layer-rule = [
        # Waybar: blur/тень под баром
        {
          match._props.namespace._raw = ''r#"^waybar$"#'';
          place-within-backdrop = true;
        }
        # Mako: не видны в screen-share
        {
          match._props.namespace._raw = ''r#"^mako$"#'';
          block-out-from = "screencast";
        }
      ];

      # ── Clipboard ──────────────────────────────────────────
      # Primary clipboard оставлен включённым по умолчанию.
      # cliphist автонаполнение — в spawn-sh-at-startup ниже.

      # ── Spawn at startup ────────────────────────────────────
      spawn-at-startup = [
        [
          "niri"
          "msg"
          "action"
          "focus-monitor"
          "DP-1"
        ]
        [
          "swaybg"
          "-o"
          "DP-1"
          "-i"
          "${wallpaperXiaomi}"
          "-m"
          "fill"
          "-o"
          "DP-2"
          "-i"
          "${wallpaperPhilips}"
          "-m"
          "fill"
        ]
        [ "waybar" ]
        [ "lxqt-policykit-agent" ]
        [ "gammastep-indicator" ]
        # cliphist автонаполнение (best practice из niri wiki)
        [
          "sh"
          "-c"
          "wl-paste --type text --watch cliphist store"
        ]
        [
          "sh"
          "-c"
          "wl-paste --type image --watch cliphist store"
        ]
        # Autostart apps
        [ "firefox" ]
        [ "chatterino" ]
        [ "superproductivity" ]
        [
          "localsend_app"
          "--hidden"
        ]
        [ "com.ayugram.desktop" ]
      ];

      # ── Animations (per-spring) ─────────────────────────────
      animations = {
        slowdown = 1.0;
        workspace-switch = {
          spring._props = {
            damping-ratio = 0.80;
            stiffness = 512;
            epsilon = 0.0001;
          };
        };
        window-open = {
          duration-ms = 90;
          curve = "ease-out-expo";
        };
        window-close = {
          duration-ms = 90;
          curve = "ease-out-quad";
        };
        horizontal-view-movement = {
          spring._props = {
            damping-ratio = 0.85;
            stiffness = 414;
            epsilon = 0.0001;
          };
        };
        window-movement = {
          spring._props = {
            damping-ratio = 0.75;
            stiffness = 316;
            epsilon = 0.0001;
          };
        };
        config-notification-open-close = {
          spring._props = {
            damping-ratio = 0.65;
            stiffness = 904;
            epsilon = 0.001;
          };
        };
      };

      # ── Window rules ────────────────────────────────────────
      window-rule = [
        # Глобально: скруглённые углы
        {
          geometry-corner-radius = 8;
          clip-to-geometry = true;
        }
        # DP-1: web + minecraft
        {
          match._props.app-id = "firefox";
          open-on-workspace = "web";
        }
        {
          match._props.title._raw = ''r#"^Minecraft"#'';
          open-on-workspace = "minecraft";
        }
        {
          match._props.app-id._raw = ''r#"^(steam_proton|epicgameslauncher.exe|rocketleague.exe|bakkesmod.exe)$"#'';
          open-on-workspace = "minecraft";
        }
        # DP-2: app-specific
        {
          match._props.app-id = "firefox-seven";
          open-on-workspace = "七";
        }
        {
          match._props.app-id._raw = ''r#"^(discord|vesktop|legcord|anilibrix)$"#'';
          open-on-workspace = "discord";
        }
        {
          match._props.app-id._raw = ''r#"^(TelegramDesktop|ayugram-desktop|com\.ayugram\.desktop)$"#'';
          open-on-workspace = "telegram";
          open-focused = false;
        }
        {
          match._props.app-id._raw = ''r#"^com\.chatterino\."#'';
          open-on-workspace = "chatterino";
          open-focused = false;
        }
        {
          match._props.app-id._raw = ''r#"^localsend_app$"#'';
          open-on-workspace = "localsend";
        }
        {
          match._props.app-id._raw = ''r#"^superproductivity$"#'';
          open-on-workspace = "superprod";
        }
        {
          match._props.app-id._raw = ''r#"^(easyeffects|nekoray|hiddify|v2rayN)$"#'';
          open-on-workspace = "easyeffects";
        }
        # Floating
        {
          match._props.app-id = "mpv";
          open-floating = true;
          default-column-width._children = [ { proportion = 0.8; } ];
        }
        {
          match._props.app-id._raw = ''r#"^(pavucontrol|qbittorrent|ripdrag|pinentry|ssh-askpass|Blueman-manager|Gpick)$"#'';
          open-floating = true;
        }
        {
          match._props.title._raw = ''r#"^(branchdialog|pinentry|Event Tester)$"#'';
          open-floating = true;
        }
        # Bakkesmod: full height
        {
          match._props.app-id = "bakkesmod.exe";
          default-window-height._children = [ { proportion = 0.0; } ];
        }
      ];

      # ── Binds ───────────────────────────────────────────────
      binds =
        let
          # Хелпер: bind с cooldown-ms для скролла
          withCooldown = ms: { cooldown-ms = ms; };
        in
        {
          "Mod+S" = {
            show-hotkey-overlay = [ ];
          };
          "Mod+Shift+Slash" = {
            show-hotkey-overlay = [ ];
          };

          # ── Launchers ──────────────────────────────────────
          "Mod+Return" = {
            _props.hotkey-overlay-title = "Terminal: kitty";
            spawn = "kitty";
          };
          "Mod+D" = {
            _props.hotkey-overlay-title = "Launcher: rofi";
            spawn = "rofi -show drun";
          };
          "Mod+C" = {
            spawn-sh = "cliphist list | rofi -dmenu -display-input 'Clipboard' | cliphist decode | wl-copy";
          };
          "Mod+Shift+P" = {
            spawn = "rofi-pass";
          };
          "Mod+X" = {
            spawn-sh = "rofi -show power-menu -theme-str 'window { width: 20%; }'";
          };

          # ── Window management ──────────────────────────────
          "Mod+Q" = {
            _props.repeat = false;
            close-window = [ ];
          };
          "Mod+Shift+Q" = {
            quit = [ ];
          };

          # ── Focus: arrows (intuitive) ──────────────────────
          "Mod+Left" = {
            focus-column-left = [ ];
          };
          "Mod+Right" = {
            focus-column-right = [ ];
          };
          "Mod+Down" = {
            focus-window-down = [ ];
          };
          "Mod+Up" = {
            focus-window-up = [ ];
          };

          # ── Focus: vim-style (HJKL) ─────────────────────────
          "Mod+H" = {
            focus-column-left = [ ];
          };
          "Mod+L" = {
            focus-column-right = [ ];
          };
          "Mod+J" = {
            focus-window-down = [ ];
          };
          "Mod+K" = {
            focus-window-up = [ ];
          };

          # ── Focus: or-workspace variants ───────────────────
          "Mod+Ctrl+Down" = {
            focus-window-or-workspace-down = [ ];
          };
          "Mod+Ctrl+Up" = {
            focus-window-or-workspace-up = [ ];
          };
          "Mod+Ctrl+J" = {
            focus-window-or-workspace-down = [ ];
          };
          "Mod+Ctrl+K" = {
            focus-window-or-workspace-up = [ ];
          };

          # ── Focus previous window ──────────────────────────
          "Mod+Shift+Tab" = {
            focus-window-previous = [ ];
          };

          # ── Move windows ────────────────────────────────────
          "Mod+Shift+Left" = {
            move-column-left = [ ];
          };
          "Mod+Shift+Right" = {
            move-column-right = [ ];
          };
          "Mod+Shift+Down" = {
            move-window-down = [ ];
          };
          "Mod+Shift+Up" = {
            move-window-up = [ ];
          };
          "Mod+Shift+H" = {
            move-column-left = [ ];
          };
          "Mod+Shift+L" = {
            move-column-right = [ ];
          };
          "Mod+Shift+J" = {
            move-window-down = [ ];
          };
          "Mod+Shift+K" = {
            move-window-up = [ ];
          };

          # ── Swap windows (master/stack-like) ────────────────
          "Mod+Alt+H" = {
            swap-window-left = [ ];
          };
          "Mod+Alt+L" = {
            swap-window-right = [ ];
          };

          # ── Move across workspaces ──────────────────────────
          "Mod+Ctrl+Shift+Down" = {
            move-window-down-or-to-workspace-down = [ ];
          };
          "Mod+Ctrl+Shift+Up" = {
            move-window-up-or-to-workspace-up = [ ];
          };
          "Mod+Ctrl+Shift+J" = {
            move-window-down-or-to-workspace-down = [ ];
          };
          "Mod+Ctrl+Shift+K" = {
            move-window-up-or-to-workspace-up = [ ];
          };

          # ── First / last ────────────────────────────────────
          "Mod+Home" = {
            focus-column-first = [ ];
          };
          "Mod+End" = {
            focus-column-last = [ ];
          };
          "Mod+Ctrl+Home" = {
            move-column-to-first = [ ];
          };
          "Mod+Ctrl+End" = {
            move-column-to-last = [ ];
          };

          # ── Monitor focus ────────────────────────────────────
          "Mod+Alt+Left" = {
            focus-monitor-left = [ ];
          };
          "Mod+Alt+Right" = {
            focus-monitor-right = [ ];
          };
          "Mod+Alt+Up" = {
            focus-monitor-up = [ ];
          };
          "Mod+Alt+Down" = {
            focus-monitor-down = [ ];
          };

          # ── Move column to monitor ──────────────────────────
          "Mod+Alt+Shift+Left" = {
            move-column-to-monitor-left = [ ];
          };
          "Mod+Alt+Shift+Right" = {
            move-column-to-monitor-right = [ ];
          };
          "Mod+Alt+Shift+Up" = {
            move-column-to-monitor-up = [ ];
          };
          "Mod+Alt+Shift+Down" = {
            move-column-to-monitor-down = [ ];
          };

          # ── Workspace navigation ─────────────────────────────
          "Mod+Page_Down" = {
            focus-workspace-down = [ ];
          };
          "Mod+Page_up" = {
            focus-workspace-up = [ ];
          };
          "Mod+U" = {
            focus-workspace-down = [ ];
          };
          "Mod+I" = {
            focus-workspace-up = [ ];
          };
          "Mod+Tab" = {
            focus-workspace-previous = [ ];
          };
          "Mod+Escape" = {
            focus-workspace-previous = [ ];
          };

          # ── Move workspace ──────────────────────────────────
          "Mod+Shift+Page_Down" = {
            move-workspace-down = [ ];
          };
          "Mod+Shift+Page_Up" = {
            move-workspace-up = [ ];
          };
          "Mod+Shift+U" = {
            move-workspace-down = [ ];
          };
          "Mod+Shift+I" = {
            move-workspace-up = [ ];
          };

          # ── Move column to workspace ───────────────────────
          "Mod+Ctrl+Page_Down" = {
            move-column-to-workspace-down = [ ];
          };
          "Mod+Ctrl+Page_Up" = {
            move-column-to-workspace-up = [ ];
          };
          "Mod+Ctrl+U" = {
            move-column-to-workspace-down = [ ];
          };
          "Mod+Ctrl+I" = {
            move-column-to-workspace-up = [ ];
          };

          # ── Wheel scroll ─────────────────────────────────────
          "Mod+WheelScrollDown" = {
            _props = withCooldown 150;
            focus-workspace-down = [ ];
          };
          "Mod+WheelScrollUp" = {
            _props = withCooldown 150;
            focus-workspace-up = [ ];
          };
          "Mod+Ctrl+WheelScrollDown" = {
            _props = withCooldown 150;
            move-column-to-workspace-down = [ ];
          };
          "Mod+Ctrl+WheelScrollUp" = {
            _props = withCooldown 150;
            move-column-to-workspace-up = [ ];
          };

          "Mod+WheelScrollRight" = {
            focus-column-right = [ ];
          };
          "Mod+WheelScrollLeft" = {
            focus-column-left = [ ];
          };
          "Mod+Ctrl+WheelScrollRight" = {
            move-column-right = [ ];
          };
          "Mod+Ctrl+WheelScrollLeft" = {
            move-column-left = [ ];
          };

          # ── Workspaces: DP-1 (left) 一-六 ───────────────────
          "Mod+1" = {
            focus-workspace = "一";
          };
          "Mod+2" = {
            focus-workspace = "二";
          };
          "Mod+3" = {
            focus-workspace = "三";
          };
          "Mod+4" = {
            focus-workspace = "四";
          };
          "Mod+5" = {
            focus-workspace = "五";
          };
          "Mod+6" = {
            focus-workspace = "六";
          };

          "Mod+Ctrl+1" = {
            move-column-to-workspace = "一";
          };
          "Mod+Ctrl+2" = {
            move-column-to-workspace = "二";
          };
          "Mod+Ctrl+3" = {
            move-column-to-workspace = "三";
          };
          "Mod+Ctrl+4" = {
            move-column-to-workspace = "四";
          };
          "Mod+Ctrl+5" = {
            move-column-to-workspace = "五";
          };
          "Mod+Ctrl+6" = {
            move-column-to-workspace = "六";
          };

          # ── Workspaces: DP-2 (right) 七-十二 ───────────────
          "Mod+7" = {
            focus-workspace = "七";
          };
          "Mod+8" = {
            focus-workspace = "八";
          };
          "Mod+9" = {
            focus-workspace = "九";
          };
          "Mod+0" = {
            focus-workspace = "十";
          };
          "Mod+Minus" = {
            focus-workspace = "十一";
          };
          "Mod+Equal" = {
            focus-workspace = "十二";
          };

          "Mod+Ctrl+7" = {
            move-column-to-workspace = "七";
          };
          "Mod+Ctrl+8" = {
            move-column-to-workspace = "八";
          };
          "Mod+Ctrl+9" = {
            move-column-to-workspace = "九";
          };
          "Mod+Ctrl+0" = {
            move-column-to-workspace = "十";
          };
          "Mod+Ctrl+Minus" = {
            move-column-to-workspace = "十一";
          };
          "Mod+Ctrl+Equal" = {
            move-column-to-workspace = "十二";
          };

          # ── Named workspaces (app-specific) ─────────────────
          "Mod+W" = {
            focus-workspace = "web";
          };
          "Mod+Ctrl+W" = {
            move-column-to-workspace = "web";
          };
          "Mod+G" = {
            focus-workspace = "minecraft";
          };
          "Mod+Ctrl+G" = {
            move-column-to-workspace = "minecraft";
          };
          "Mod+F1" = {
            focus-workspace = "discord";
          };
          "Mod+Ctrl+F1" = {
            move-column-to-workspace = "discord";
          };
          "Mod+F2" = {
            focus-workspace = "localsend";
          };
          "Mod+Ctrl+F2" = {
            move-column-to-workspace = "localsend";
          };
          "Mod+F3" = {
            focus-workspace = "superprod";
          };
          "Mod+Ctrl+F3" = {
            move-column-to-workspace = "superprod";
          };
          "Mod+E" = {
            focus-workspace = "easyeffects";
          };
          "Mod+Ctrl+E" = {
            move-column-to-workspace = "easyeffects";
          };
          "Mod+R" = {
            focus-workspace = "chatterino";
          };
          "Mod+Ctrl+R" = {
            move-column-to-workspace = "chatterino";
          };
          "Mod+T" = {
            focus-workspace = "telegram";
          };
          "Mod+Ctrl+T" = {
            move-column-to-workspace = "telegram";
          };

          # ── Column consume / expel ───────────────────────────
          "Mod+Ctrl+BracketLeft" = {
            consume-or-expel-window-left = [ ];
          };
          "Mod+Ctrl+BracketRight" = {
            consume-or-expel-window-right = [ ];
          };
          "Mod+Comma" = {
            consume-window-into-column = [ ];
          };
          "Mod+Period" = {
            expel-window-from-column = [ ];
          };

          # ── Column width presets ─────────────────────────────
          "Mod+B" = {
            switch-preset-column-width = [ ];
          };
          "Mod+Shift+B" = {
            switch-preset-column-width-back = [ ];
          };

          # ── Window height presets ────────────────────────────
          "Mod+Alt+R" = {
            switch-preset-window-height = [ ];
          };
          "Mod+Alt+Shift+R" = {
            reset-window-height = [ ];
          };

          # ── Maximize / fullscreen ────────────────────────────
          "Mod+F" = {
            maximize-column = [ ];
          };
          "Mod+Shift+F" = {
            fullscreen-window = [ ];
          };
          "Mod+M" = {
            maximize-window-to-edges = [ ];
          };

          # ── Expand column ─────────────────────────────────────
          "Mod+Ctrl+F" = {
            expand-column-to-available-width = [ ];
          };

          # ── Center ────────────────────────────────────────────
          "Mod+Shift+C" = {
            center-column = [ ];
          };
          "Mod+Ctrl+Shift+C" = {
            center-visible-columns = [ ];
          };

          # ── Column width adjustments ─────────────────────────
          "Mod+BracketLeft" = {
            set-column-width = "-10%";
          };
          "Mod+BracketRight" = {
            set-column-width = "+10%";
          };

          # ── Window height adjustments ────────────────────────
          "Mod+Shift+BracketLeft" = {
            set-window-height = "-10%";
          };
          "Mod+Shift+BracketRight" = {
            set-window-height = "+10%";
          };

          # ── Floating / tiling ─────────────────────────────────
          "Mod+Y" = {
            toggle-window-floating = [ ];
          };
          "Mod+Shift+Y" = {
            switch-focus-between-floating-and-tiling = [ ];
          };

          # ── Tabbed column display ─────────────────────────────
          "Mod+Shift+T" = {
            toggle-column-tabbed-display = [ ];
          };

          # ── Layout switch ─────────────────────────────────────
          "Mod+Space" = {
            switch-layout = "next";
          };
          "Mod+Shift+Space" = {
            switch-layout = "prev";
          };

          # ── Overview ──────────────────────────────────────────
          "Mod+grave" = {
            toggle-overview = [ ];
          };
          "Mod+O" = {
            _props.repeat = false;
            toggle-overview = [ ];
          };

          # ── Screenshots ──────────────────────────────────────
          "Print" = {
            spawn-sh = "screenshot.sh area";
          };
          "Shift+Print" = {
            spawn-sh = "screenshot.sh full";
          };
          "Mod+Print" = {
            spawn-sh = "screenshot.sh upload";
          };
          "Ctrl+Print" = {
            spawn-sh = "screenshot.sh qr";
          };
          "Mod+Shift+Print" = {
            spawn-sh = "screenshot.sh menu";
          };

          # ── Volume ────────────────────────────────────────────
          "XF86AudioRaiseVolume" = {
            _props.allow-when-locked = true;
            spawn-sh = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
          };
          "XF86AudioLowerVolume" = {
            _props.allow-when-locked = true;
            spawn-sh = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
          };
          "XF86AudioMute" = {
            _props.allow-when-locked = true;
            spawn-sh = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          };
          "XF86AudioMicMute" = {
            _props.allow-when-locked = true;
            spawn-sh = "pactl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          };

          # ── Media keys ───────────────────────────────────────
          "XF86AudioPlay" = {
            _props.allow-when-locked = true;
            spawn-sh = "playerctl play-pause";
          };
          "XF86AudioPause" = {
            _props.allow-when-locked = true;
            spawn-sh = "playerctl play-pause";
          };
          "XF86AudioStop" = {
            _props.allow-when-locked = true;
            spawn-sh = "playerctl stop";
          };
          "XF86AudioPrev" = {
            _props.allow-when-locked = true;
            spawn-sh = "playerctl previous";
          };
          "XF86AudioNext" = {
            _props.allow-when-locked = true;
            spawn-sh = "playerctl next";
          };

          # ── Brightness ───────────────────────────────────────
          "XF86MonBrightnessUp" = {
            _props.allow-when-locked = true;
            spawn = [
              "brightnessctl"
              "--class=backlight"
              "set"
              "+10%"
            ];
          };
          "XF86MonBrightnessDown" = {
            _props.allow-when-locked = true;
            spawn = [
              "brightnessctl"
              "--class=backlight"
              "set"
              "10%-"
            ];
          };

          # ── Lock / power ─────────────────────────────────────
          "Mod+Ctrl+L" = {
            spawn = "swaylock";
          };
          "Mod+Shift+Ctrl+P" = {
            power-off-monitors = [ ];
          };

          # ── Inhibitor escape hatch ──────────────────────────
          "Mod+Shift+Escape" = {
            _props.allow-inhibiting = false;
            toggle-keyboard-shortcuts-inhibit = [ ];
          };
        };
    };
  };

  home.packages = with pkgs; [
    xwayland-satellite
  ];
}
