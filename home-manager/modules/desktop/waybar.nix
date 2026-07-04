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
      "custom/mem"
      "cpu"
      "pulseaudio"
    ];

    "niri/workspaces" = {
      format = "{icon}";
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
    };

    clock = {
      format = "󰥔 {:%H:%M}";
      format-alt = "󰃭 {:%Y-%m-%d}";
      tooltip-format = "{:%A, %B %d %Y}";
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

    "custom/mem" = {
      format = "{}";
      exec = "$HOME/.local/bin/mem.sh";
      interval = 2;
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

    #custom-mem {
        color: #e0af68;
    }

    #custom-weather {
        color: #7dcfff;
    }

    #tray {
        padding: 0 8px;
    }
  '';
}
