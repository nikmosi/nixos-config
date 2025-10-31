{ pkgs, ... }:

let
  # Animation profiles — pick your poison
  animationProfiles = {
    fast = [
      # open/close: subtle zoom + fade, Hypr-ish but restrained
      {
        triggers = [ "open" ];
        preset = "appear";
        scale = 1.03;
        duration = 0.10;
      }
      {
        triggers = [ "close" ];
        preset = "disappear";
        scale = 1.03;
        duration = 0.08;
      }

      # unminimize/minimize: quick slide so it feels “alive”
      {
        triggers = [ "show" ];
        preset = "slide-in";
        direction = "up";
        duration = 0.08;
      }
      {
        triggers = [ "hide" ];
        preset = "slide-out";
        direction = "down";
        duration = 0.08;
      }
    ];

    veryFast = [
      {
        triggers = [ "open" ];
        preset = "appear";
        scale = 1.02;
        duration = 0.07;
      }
      {
        triggers = [ "close" ];
        preset = "disappear";
        scale = 1.02;
        duration = 0.06;
      }
      {
        triggers = [ "show" ];
        preset = "slide-in";
        direction = "up";
        duration = 0.06;
      }
      {
        triggers = [ "hide" ];
        preset = "slide-out";
        direction = "down";
        duration = 0.06;
      }
    ];
  };

  # choose either animationProfiles.fast or animationProfiles.veryFast
  chosenProfile = animationProfiles.veryFast;
in
{
  services.picom = {
    enable = true;

    # Make sure you're on X11; Hyprland is Wayland and doesn't use picom.
    # Upstream picom package is fine (has animations + rules).
    package = pkgs.picom;

    settings = {
      ################################
      # Performance / backend
      ################################
      backend = "glx";
      vsync = true;
      use-damage = true;

      # These xrender flags are irrelevant on GLX; drop the old ones for less jank.
      # unredir-if-possible can cause flicker; keep it off for smoothness.
      unredir-if-possible = false;

      ################################
      # Look: shadows / blur / corners
      ################################
      shadow = true;
      shadow-radius = 18;
      shadow-opacity = 0.32;
      shadow-offset-x = -12;
      shadow-offset-y = -12;

      # tasteful rounded corners (disable on fullscreen via a rule below)
      corner-radius = 12;

      # lightweight blur; bump size to 14–18 if your GPU laughs at this
      blur = {
        method = "gaussian";
        size = 12;
        deviation = 4.0;
      };

      ################################
      # Animations (Hypr vibes, but snappy)
      ################################
      animations = chosenProfile;

      ################################
      # Rules: keep UI crisp & avoid weird cases
      ################################
      rules = [
        # No blur/shadows on docks, desktop, or fullscreens (keeps fps stable)
        {
          match = "window_type = 'dock' || window_type = 'desktop'";
          shadow = false;
          blur-background = false;
        }
        {
          match = "fullscreen";
          corner-radius = 0;
          shadow = false;
        }

        # Menus/tooltips should be instant and sharp
        {
          match = "window_type *= 'dropdown_menu' || window_type *= 'popup_menu' || window_type *= 'tooltip'";
          blur-background = false;
          shadow = false;
        }

        # Launchers & notifs: no blur/shadow (feels cleaner)
        {
          match = "class_g *?= 'Rofi' || class_g *?= 'wofi' || class_g *?= 'dunst'";
          blur-background = false;
          shadow = false;
        }

        # Slightly less transparent terminals by default
        {
          match = "class_g = 'Alacritty' || class_g = 'kitty' || class_g = 'foot'";
          opacity = 0.98;
        }
      ];
    };
  };
}
