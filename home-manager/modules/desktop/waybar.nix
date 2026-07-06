{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    systemd.enable = false;
  };

  xdg.configFile."waybar/config".text = builtins.toJSON {
    layer = "top";
    position = "top";
    height = 40;
    spacing = 12;

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
      format = "{icon} {windows}";
      format-window-separator = " ";
      window-rewrite-default = "";
      window-rewrite = {
        "app_id<firefox>" = "";
        "app_id<firefox-seven>" = "";
        "app_id<discord>" = "";
        "app_id<vesktop>" = "";
        "app_id<legcord>" = "";
        "app_id<TelegramDesktop>" = "";
        "app_id<ayugram-desktop>" = "";
        "app_id<com.chatterino.Chatterino>" = "💬";
        "app_id<mpv>" = "";
        "app_id<kitty>" = "";
        "app_id<org.qbittorrent.qBittorrent>" = "";
        "app_id<easyeffects>" = "🎵";
        "app_id<superproductivity>" = "✓";
        "app_id<localsend_app>" = "📤";
        "class<Minecraft.*>" = "⛏";
      };
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
        "十一" = "十一";
        "十二" = "十二";
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
        "(.*) — Mozilla Firefox" = " $1";
        "(.*) — Chatterino" = "💬 $1";
        "(.*) — Discord" = " $1";
        "(.*) — Telegram" = " $1";
      };
    };

    clock = {
      format = "󰥔 {:%H:%M}";
      format-alt = "󰃭 {:%Y-%m-%d}";
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
      format = "󰻆  {usage}%";
      interval = 2;
      max-length = 10;
    };

    memory = {
      format = "󰍛 {used}/{total} GB";
      interval = 2;
    };

    temperature = {
      thermal-zone = 2;
      critical-threshold = 80;
      format = "{temperatureC}°C {icon}";
      format-icons = [
        "󰉬"
        ""
        "󰉪"
      ];
    };

    network = {
      format-wifi = "{essid} ({signalStrength}%) ";
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
        spotify = "";
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
      on-click = "swaynag -t warning -m 'Power' -b 'Logout' 'niri msg action quit' -b 'Suspend' 'systemctl suspend' -b 'Reboot' 'systemctl reboot' -b 'Shutdown' 'systemctl poweroff'";
    };
  };

  xdg.configFile."waybar/style.css".text = ''
    * {
        font-family: "JetBrainsMono Nerd Font Mono", "Symbols Nerd Font Mono", "Noto Sans CJK JP";
        font-size: 18px;
    }

    window#waybar {
        background-color: #1a1b26;
        color: #c0caf5;
        border-bottom: 1px solid #1f2335;
    }

    .modules-left > widget,
    .modules-center > widget {
        padding: 0 12px;
        margin: 4px 2px;
        background-color: #1f2335;
        border-radius: 6px;
    }

    .modules-right > widget {
        padding: 0 12px;
        margin: 4px 12px;
        background-color: #1f2335;
        border-radius: 6px;
    }

    #workspaces button {
        padding: 0 8px;
        color: #565f89;
        background: transparent;
        border-radius: 6px;
    }

    #workspaces button.active {
        color: #7aa2f7;
        background: #373b41;
    }

    #workspaces button.occupied {
        color: #c0caf5;
        border-bottom: 2px solid #7aa2f7;
    }

    #workspaces button.urgent {
        color: #f7768e;
    }

    #window {
        color: #c0caf5;
    }

    #clock {
        font-weight: bold;
        color: #7aa2f7;
    }

    #pulseaudio {
        color: #9ece6a;
    }

    #pulseaudio.muted {
        color: #565f89;
    }

    #cpu {
        color: #bb9af7;
    }

    #memory {
        color: #e0af68;
    }

    #temperature {
        color: #e0af68;
    }

    #temperature.critical {
        color: #f7768e;
    }

    #network {
        color: #7dcfff;
    }

    #network.disconnected {
        color: #f7768e;
    }

    #idle_inhibitor.activated {
        color: #e0af68;
    }

    #idle_inhibitor.deactivated {
        color: #565f89;
    }

    #keyboard-state {
        color: #9ece6a;
    }

    #keyboard-state.locked {
        color: #f7768e;
    }

    #custom-media {
        color: #9ece6a;
    }

    #custom-weather {
        color: #7dcfff;
    }

    #custom-power {
        color: #f7768e;
    }

    #tray {
        padding: 0 8px;
    }

    #language {
        color: #7dcfff;
    }
  '';
}
