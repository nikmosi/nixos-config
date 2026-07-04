{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
  };

  xdg.configFile."waybar/config".text = builtins.toJSON {
    layer = "top";
    position = "top";
    height = 30;
    spacing = 4;

    modules-left = [
      "niri/workspaces"
      "niri/window"
    ];

    modules-center = [ "clock" ];

    modules-right = [
      "pulseaudio"
      "cpu"
      "memory"
      "tray"
    ];

    "niri/workspaces" = {
      format = "{name}";
      format-icons = {
        "web" = "🌐";
        "discord" = "";
        "telegram" = "✈";
        "chatterino" = "💬";
        "minecraft" = "⛏";
        "easyeffects" = "🎵";
        "localsend" = "📤";
        "superprod" = "✓";
      };
    };

    "niri/window" = {
      format = "{}";
      max-length = 50;
    };

    clock = {
      format = "{:%H:%M}";
      format-alt = "{:%Y-%m-%d}";
      tooltip-format = "{:%A %B %d %Y}";
    };

    pulseaudio = {
      format = "{volume}% {icon}";
      format-muted = "🔇";
      format-icons = {
        headphone = "🎧";
        default = [
          "🔈"
          "🔉"
          "🔊"
        ];
      };
      on-click = "pavucontrol";
    };

    cpu = {
      format = "🧠 {usage}%";
      interval = 2;
    };

    memory = {
      format = "💾 {percentage}%";
      interval = 2;
    };

    tray = {
      spacing = 8;
    };
  };

  xdg.configFile."waybar/style.css".text = ''
    * {
        font-family: "JetBrains Mono", "Symbols Nerd Font Mono";
        font-size: 13px;
    }

    window#waybar {
        background-color: #1e2030;
        color: #cad3f5;
        border-bottom: 1px solid #494d64;
    }

    .modules-right > * {
        padding: 0 8px;
        margin: 4px 2px;
        background-color: #24273a;
        border-radius: 6px;
    }

    .modules-left > * {
        padding: 0 8px;
        margin: 4px 2px;
        background-color: #24273a;
        border-radius: 6px;
    }

    .modules-center > * {
        padding: 0 12px;
        margin: 4px 2px;
        background-color: #24273a;
        border-radius: 6px;
    }

    #workspaces button {
        padding: 0 6px;
        color: #6e738d;
        background: transparent;
        border-radius: 6px;
    }

    #workspaces button.active {
        color: #8aadf3;
        background: #363a4f;
    }

    #workspaces button.urgent {
        color: #ed8796;
    }

    #pulseaudio.muted {
        color: #a5adcb;
    }

    #clock {
        font-weight: bold;
        color: #8aadf3;
    }
  '';
}
