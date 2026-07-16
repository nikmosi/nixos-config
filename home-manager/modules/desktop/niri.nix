{
  pkgs,
  config,
  lib,
  hostConfig,
  ...
}:
let
  p = config.dotfiles.palette;
  c = {
    bg = p.base;
    bgHighlight = p.surface0;
    bgStatusline = p.surface0;
    fg = p.text;
    inherit (p) blue;
    inherit (p) green;
    inherit (p) yellow;
    inherit (p) red;
    cyan = p.teal;
    purple = p.mauve;
    comment = p.overlay0;
  };

  # Nerd Font PUA symbols for non-numeric workspaces
  nf = code: builtins.fromJSON ''"\u${code}"'';
  ws = {
    web = nf "f269"; # firefox
    minecraft = nf "f1b2"; # cube
    discord = nf "f2ee"; # discord
    telegram = nf "f3cd"; # telegram
    chatterino = "󰭹 "; # comments
    localsend = nf "f1e0"; # share-alt
    superprod = nf "f14a"; # check-square
    easyeffects = nf "f001"; # music
  };

  # Monitor config from NixOS options
  monitors = hostConfig.nik.monitors or [ ];
  hasMonitors = builtins.length monitors > 0;
  hasSecondMonitor = builtins.length monitors >= 2;
  monitorOutputs = map (
    m:
    {
      _args = [ m.name ];
      inherit (m) mode;
      position._props = {
        inherit (m) x y;
      };
    }
    // (lib.optionalAttrs (m.vrr or true) {
      variable-refresh-rate = [ ];
    })
  ) monitors;
  monitorFirst = if hasMonitors then builtins.head monitors else null;
  monitorSecondName =
    if hasSecondMonitor then
      (builtins.elemAt monitors 1).name
    else
      (if hasMonitors then monitorFirst.name else "eDP-1");

  # Workspace names
  wsFirst = [
    "一"
    "二"
    "三"
    "四"
    "五"
  ];
  wsSecond = [
    "六"
    "七"
    "八"
    "九"
    "十"
  ];

  # Build workspace entries for a given output name and workspace name list
  mkWorkspaces =
    output: names:
    map (name: {
      _args = [ name ];
      open-on-output = output;
    }) names;

  # App-specific workspaces (always on second monitor if present, else first)
  appOutput =
    if hasSecondMonitor then
      monitorSecondName
    else
      (if hasMonitors then monitorFirst.name else "eDP-1");
  appWorkspaces = [
    {
      _args = [ ws.discord ];
      open-on-output = appOutput;
    }
    {
      _args = [ ws.telegram ];
      open-on-output = appOutput;
    }
    {
      _args = [ ws.chatterino ];
      open-on-output = appOutput;
    }
    {
      _args = [ ws.localsend ];
      open-on-output = appOutput;
    }
    {
      _args = [ ws.superprod ];
      open-on-output = appOutput;
    }
    {
      _args = [ ws.easyeffects ];
      open-on-output = appOutput;
    }
  ];
in
{
  config = lib.mkIf config.local.desktop.niri.enable {
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

        # ── Named workspaces ───────────────────────────────────
        # First monitor: 一-五 + web + minecraft
        # Second monitor (if present): 六-十 + app-specific
        # Single monitor: all workspaces on first output
        workspace =
          let
            firstOutput = if hasMonitors then monitorFirst.name else "eDP-1";
            secondOutput = if hasSecondMonitor then monitorSecondName else firstOutput;
          in
          lib.optionals hasMonitors (
            (mkWorkspaces firstOutput wsFirst)
            ++ [
              {
                _args = [ ws.web ];
                open-on-output = firstOutput;
              }
              {
                _args = [ ws.minecraft ];
                open-on-output = firstOutput;
              }
            ]
            ++ (mkWorkspaces secondOutput wsSecond)
            ++ appWorkspaces
          );

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
          # Noctalia bar: blur/тень под баром
          {
            match._props.namespace._raw = ''r#"^noctalia-(bar-[^"]+|notification|dock|panel|attached-panel|osd)$"#'';
            place-within-backdrop = true;
          }
          # Noctalia notifications: не видны в screen-share
          {
            match._props.namespace._raw = ''r#"^noctalia-notification"#'';
            block-out-from = "screencast";
          }
        ];

        # ── Clipboard ──────────────────────────────────────────
        # Primary clipboard оставлен включённым по умолчанию.
        # cliphist автонаполнение — в spawn-sh-at-startup ниже.

        # ── Spawn at startup ────────────────────────────────────
        spawn-at-startup =
          lib.optionals hasMonitors [
            [
              "niri"
              "msg"
              "action"
              "focus-monitor"
              "${monitorFirst.name}"
            ]
            (
              [
                "swaybg"
              ]
              ++ lib.concatMap (m: [
                "-o"
                m.name
                "-i"
                "${m.wallpaper}"
                "-m"
                "fill"
              ]) monitors
            )
          ]
          ++ [
            [ "noctalia" ]
            [ "lxqt-policykit-agent" ]
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
            [
              "sh"
              "-c"
              "sleep 3 && exec chatterino"
            ]
            [ "superproductivity" ]
            [
              "localsend_app"
              "--hidden"
            ]
            [ "AyuGram" ]
            [
              "handy"
              "--start-hidden"
            ]
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
            open-on-workspace = ws.web;
          }
          {
            match._props.title._raw = ''r#"^Minecraft"#'';
            open-on-workspace = ws.minecraft;
          }
          {
            match._props.app-id._raw = ''r#"^(steam_proton|epicgameslauncher.exe|rocketleague.exe|bakkesmod.exe)$"#'';
            open-on-workspace = ws.minecraft;
          }
          # DP-2: app-specific
          {
            match._props.app-id = "firefox-seven";
            open-on-workspace = "七";
          }
          {
            match._props.app-id._raw = ''r#"^(discord|vesktop|legcord|anilibrix)$"#'';
            open-on-workspace = ws.discord;
          }
          {
            match._props.app-id._raw = ''r#"^(TelegramDesktop|ayugram-desktop|com\.ayugram\.desktop)$"#'';
            open-on-workspace = ws.telegram;
            open-focused = false;
          }
          {
            match._props.app-id._raw = ''r#"^com\.chatterino\."#'';
            open-on-workspace = ws.chatterino;
            open-focused = false;
          }
          {
            match._props.app-id._raw = ''r#"^localsend_app$"#'';
            open-on-workspace = ws.localsend;
          }
          {
            match._props.app-id._raw = ''r#"^superproductivity$"#'';
            open-on-workspace = ws.superprod;
          }
          {
            match._props.app-id._raw = ''r#"^(easyeffects|nekoray|hiddify|v2rayN)$"#'';
            open-on-workspace = ws.easyeffects;
          }
          # Floating
          {
            match._props.app-id = "mpv";
            open-floating = true;
            default-column-width._children = [ { proportion = 0.8; } ];
          }
          {
            match._props.app-id._raw = ''r#"^(pavucontrol|qbittorrent|ripdrag|ssh-askpass|Blueman-manager|Gpick)$"#'';
            open-floating = true;
          }
          {
            match._props.title._raw = ''r#"^(branchdialog|Event Tester)$"#'';
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
              spawn = [
                "rofi"
                "-show"
                "drun"
              ];
            };
            "Mod+S" = {
              _props.hotkey-overlay-title = "Control Center: Noctalia";
              spawn-sh = "noctalia msg panel-toggle control-center";
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
            "Mod+V" = {
              _props.hotkey-overlay-title = "Voice Transcription: handy";
              spawn = "handy --toggle-transcription";
            };

            # ── Window management ──────────────────────────────
            "Mod+Q" = {
              _props.repeat = false;
              close-window = [ ];
            };
            "Mod+Shift+Q" = {
              quit = [ ];
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

            # ── Move across workspaces ──────────────────────────
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
            "Mod+Alt+H" = {
              focus-monitor-left = [ ];
            };
            "Mod+Alt+L" = {
              focus-monitor-right = [ ];
            };

            # ── Move column to monitor ──────────────────────────
            "Mod+Alt+Shift+H" = {
              move-column-to-monitor-left = [ ];
            };
            "Mod+Alt+Shift+L" = {
              move-column-to-monitor-right = [ ];
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

            # ── Workspaces: DP-2 (right) 七-十二 ───────────────
            "Mod+6" = {
              focus-workspace = "六";
            };
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

            "Mod+Ctrl+6" = {
              move-column-to-workspace = "六";
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

            # ── Named workspaces (app-specific) ─────────────────
            "Mod+W" = {
              focus-workspace = ws.web;
            };
            "Mod+Ctrl+W" = {
              move-column-to-workspace = ws.web;
            };
            "Mod+G" = {
              focus-workspace = ws.minecraft;
            };
            "Mod+Ctrl+G" = {
              move-column-to-workspace = ws.minecraft;
            };
            "Mod+F1" = {
              focus-workspace = ws.discord;
            };
            "Mod+Ctrl+F1" = {
              move-column-to-workspace = ws.discord;
            };
            "Mod+F2" = {
              focus-workspace = ws.localsend;
            };
            "Mod+Ctrl+F2" = {
              move-column-to-workspace = ws.localsend;
            };
            "Mod+F3" = {
              focus-workspace = ws.superprod;
            };
            "Mod+Ctrl+F3" = {
              move-column-to-workspace = ws.superprod;
            };
            "Mod+E" = {
              focus-workspace = ws.easyeffects;
            };
            "Mod+Ctrl+E" = {
              move-column-to-workspace = ws.easyeffects;
            };
            "Mod+R" = {
              focus-workspace = ws.chatterino;
            };
            "Mod+Ctrl+R" = {
              move-column-to-workspace = ws.chatterino;
            };
            "Mod+T" = {
              focus-workspace = ws.telegram;
            };
            "Mod+Ctrl+T" = {
              move-column-to-workspace = ws.telegram;
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
              spawn-sh = "noctalia msg session lock";
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
      }
      // lib.optionalAttrs hasMonitors { output = monitorOutputs; };
    };

    home.packages = with pkgs; [
      xwayland-satellite
    ];
  };
}
