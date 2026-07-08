_: {
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings = [
      {
        layer = "top";
        position = "top";
        height = 40;
        spacing = 12;
        reload_style_on_change = true;

        modules-left = [
          "niri/workspaces"
          "niri/window"
        ];

        modules-center = [ "clock" ];

        modules-right = [
          "tray"
          "custom/weather"
          "memory"
          "cpu"
          "temperature"
          "network"
          "idle_inhibitor"
          "keyboard-state"
          "pulseaudio"
          "custom/media"
          "niri/language"
          "custom/power"
        ];

        "niri/workspaces" = {
          format = "{icon}";
          format-window-separator = " ";
          window-rewrite-default = "";
          window-rewrite = {
            "app_id<firefox>" = "";
            "app_id<firefox-seven>" = "";
            "app_id<discord>" = "";
            "app_id<vesktop>" = "";
            "app_id<legcord>" = "";
            "app_id<TelegramDesktop>" = "";
            "app_id<ayugram-desktop>" = "";
            "app_id<com.chatterino.Chatterino>" = "💬";
            "app_id<mpv>" = "";
            "app_id<kitty>" = "";
            "app_id<org.qbittorrent.qBittorrent>" = "";
            "app_id<easyeffects>" = "🎵";
            "app_id<superproductivity>" = "✓";
            "app_id<localsend_app>" = "📤";
            "class<Minecraft.*>" = "⛏";
          };
          ignore-workspaces = [ "^[0-9]+$" ];
          format-icons = {
            "一" = "一";
            "二" = "二";
            "三" = "三";
            "四" = "四";
            "五" = "五";
            "六" = "六";
            "七" = "七";
            "八" = "八";
            "九" = "九";
            "十" = "十";
            "web" = "🌐";
            "minecraft" = "⛏";
            "discord" = "🎮";
            "telegram" = "✈";
            "chatterino" = "💬";
            "localsend" = "📤";
            "superprod" = "✓";
            "easyeffects" = "🎵";
          };
        };

        "niri/window" = {
          format = "{}";
          max-length = 50;
          rewrite = {
            "(.*) — Mozilla Firefox" = " $1";
            "(.*) — Chatterino" = "💬 $1";
            "(.*) — Discord" = " $1";
            "(.*) — Telegram" = " $1";
          };
        };

        clock = {
          format = "󰥔 {:%H:%M}";
          format-alt = "󰃭 {:%a %d/%m/%Y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "󰸈  muted";
          format-icons = {
            headphone = "🎧";
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = "pavucontrol";
          on-click-middle = "$HOME/.local/bin/mute-source.sh";
          on-click-right = "$HOME/.local/bin/cycle-source.sh";
          scroll-step = 5;
        };

        cpu = {
          format = "󰻆  {usage:0.2f}%";
          interval = 2;
          max-length = 10;
        };

        memory = {
          format = "󰍛 {used:0.2f}/{total:0.2f} GB";
          interval = 2;
        };

        temperature = {
          thermal-zone = 2;
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [
            "󰉬"
            ""
            "󰉪"
          ];
        };

        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} 󰊗";
          tooltip-format = "{ifname} via {gwaddr} 󰊗";
          format-linked = "{ifname} (No IP) 󰊗";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰅾";
          };
        };

        keyboard-state = {
          numlock = true;
          capslock = true;
          format = "{icon}";
          format-icons = {
            locked = "󰍛";
            unlocked = "󰍜";
          };
        };

        "custom/media" = {
          format = "{icon} {}";
          return-type = "json";
          max-length = 40;
          format-icons = {
            spotify = "";
            default = "🎜";
          };
          escape = true;
          exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{title}}\", \"tooltip\": \"{{playerName}}: {{artist}} - {{album}} - {{title}}\", \"alt\": \"{{playerName}}\", \"class\": \"{{playerName}}\"}' -F";
          on-click = "playerctl play-pause";
          on-click-middle = "playerctl previous";
          on-click-right = "playerctl next";
        };

        "custom/weather" = {
          format = "{}";
          exec = "$HOME/.local/bin/weather.sh";
          return-type = "json";
          interval = 300;
          tooltip = true;
        };

        tray = {
          spacing = 12;
        };

        "niri/language" = {
          format-en = "🇺🇸 EN";
          format-ru = "🇷🇺 RU";
        };

        "custom/power" = {
          format = "⏻";
          tooltip = false;
          on-click = "rofi -show power-menu -theme-str 'window { width: 20%; }'";
        };
      }
    ];

    style = ''
      @define-color bg        #1a1b26;
      @define-color bg-alt    #1f2335;
      @define-color fg        #c0caf5;
      @define-color blue      #7aa2f7;
      @define-color red       #f7768e;
      @define-color green     #9ece6a;
      @define-color yellow    #e0af68;
      @define-color purple    #bb9af7;
      @define-color cyan      #7dcfff;
      @define-color orange    #ff9e64;
      @define-color mint      #73daca;
      @define-color teal      #2ac3de;
      @define-color comment   #565f89;

      * {
          border: none;
          border-radius: 0;
          min-height: 0;
          font-family: "JetBrainsMono Nerd Font", "Symbols Nerd Font", "Noto Sans CJK JP";
          font-size: 18px;
      }

      window#waybar {
          background-color: @bg;
          color: @fg;
          border-bottom: 1px solid @bg-alt;
      }

      .modules-right {
          margin-right: 16px;
      }

      /* Apply padding/background directly to module IDs, not the
         `widget` wrapper: GTK3 EventBox doesn't push its children
         inward with padding, so the background hugs the text.
         See https://github.com/Alexays/Waybar/issues (widget padding). */
      #workspaces,
      #window,
      #clock {
          padding: 0 12px;
          margin: 4px 2px;
          background-color: @bg-alt;
          border-radius: 6px;
      }

      #tray,
      #custom-weather,
      #memory,
      #cpu,
      #temperature,
      #network,
      #idle_inhibitor,
      #keyboard-state,
      #pulseaudio,
      #custom-media,
      #language,
      #custom-power {
          padding: 4px 8px;
          margin: 4px 0px;
          background-color: @bg-alt;
          border-radius: 6px;
      }

      /* ── Workspaces ────────────────────────────────────────── */
      /* Kill implicit niri/workspaces styling (issue #4876):
         without this reset, buttons flash white on hover. */
      #workspaces button {
          background: none;
          border: none;
          text-shadow: none;
          box-shadow: none;
          -gtk-icon-shadow: none;
          -gtk-icon-effect: none;
          padding: 0 8px;
          margin: 0 2px;
          color: @comment;
          border-radius: 6px;
          transition: background 0.2s, color 0.2s, box-shadow 0.2s;
      }

      #workspaces button:hover {
          background: @bg-alt;
      }

      /* empty: dimmed — low opacity for clear contrast with occupied */
      #workspaces button.empty {
          opacity: 0.3;
      }

      /* occupied: has windows — full opacity, accent color from per-workspace rules */
      #workspaces button.occupied {
          color: @fg;
          opacity: 1;
      }

      /* active: visible on its output, not focused — thin underline */
      #workspaces button.active {
          box-shadow: inset 0 -1px;
      }

      /* focused: THE focused workspace — bold + thick underline */
      #workspaces button.focused {
          color: @blue;
          font-weight: bold;
          box-shadow: inset 0 -2px;
          opacity: 1;
      }

      /* urgent: red alert (per-workspace IDs raise specificity to
         override the per-workspace color rules below) */
      #workspaces button.urgent,
      #workspaces #niri-workspace-web.urgent,
      #workspaces #niri-workspace-minecraft.urgent,
      #workspaces #niri-workspace-discord.urgent,
      #workspaces #niri-workspace-telegram.urgent,
      #workspaces #niri-workspace-chatterino.urgent,
      #workspaces #niri-workspace-localsend.urgent,
      #workspaces #niri-workspace-superprod.urgent,
      #workspaces #niri-workspace-easyeffects.urgent {
          color: @red;
          font-weight: bold;
          box-shadow: inset 0 -2px @red;
          opacity: 1;
      }

      /* ── Per-workspace accent colors ───────────────────────── */
      /* box-shadow underline uses currentColor, so it automatically
         matches the workspace's accent in active/focused states. */
      #workspaces #niri-workspace-web          { color: @cyan; }
      #workspaces #niri-workspace-minecraft    { color: @green; }
      #workspaces #niri-workspace-discord      { color: @purple; }
      #workspaces #niri-workspace-telegram     { color: @blue; }
      #workspaces #niri-workspace-chatterino   { color: @yellow; }
      #workspaces #niri-workspace-localsend    { color: @orange; }
      #workspaces #niri-workspace-superprod    { color: @mint; }
      #workspaces #niri-workspace-easyeffects  { color: @teal; }

      #window {
          color: @fg;
      }

      #clock {
          font-weight: bold;
          color: @blue;
      }

      #pulseaudio {
          color: @green;
      }

      #pulseaudio.muted {
          color: @comment;
      }

      #cpu {
          color: @purple;
      }

      #memory {
          color: @yellow;
      }

      #temperature {
          color: @yellow;
          transition: color 0.3s;
      }

      #temperature.critical {
          color: @red;
      }

      #network {
          color: @cyan;
      }

      #network.disconnected {
          color: @red;
      }

      #idle_inhibitor.activated {
          color: @yellow;
      }

      #idle_inhibitor.deactivated {
          color: @comment;
      }

      #keyboard-state {
          color: @green;
      }

      #keyboard-state.locked {
          color: @red;
      }

      #custom-media {
          color: @green;
      }

      #custom-weather {
          color: @cyan;
      }

      #custom-power {
          color: @red;
      }

      #language {
          color: @cyan;
      }
    '';
  };
}
