{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
  };

  xdg.configFile."waybar/config".text = builtins.toJSON {
    layer = "top";
    position = "top";
    height = 36;
    spacing = 4;

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
        "一" = "1";
        "二" = "2";
        "三" = "3";
        "四" = "4";
        "五" = "5";
        "六" = "6";
        "七" = "7";
        "八" = "8";
        "九" = "9";
        "十" = "10";
        "十一" = "11";
        "十二" = "12";
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
      rewrite = { };
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
      spacing = 8;
    };
  };

  xdg.configFile."waybar/style.css".text = ''
    * {
        font-family: "JetBrainsMono Nerd Font Mono", "Symbols Nerd Font Mono";
        font-size: 12px;
    }

    window#waybar {
        background-color: #1a1b26;
        color: #c0caf5;
        border-bottom: 1px solid #1f2335;
    }

    .modules-left > widget,
    .modules-center > widget,
    .modules-right > widget {
        padding: 0 8px;
        margin: 4px 2px;
        background-color: #1f2335;
        border-radius: 6px;
    }

    #workspaces button {
        padding: 0 6px;
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
        padding: 0 6px;
    }
  '';
}
