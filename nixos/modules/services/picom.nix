{ lib, pkgs, ... }:

let
  animationProfiles = {
    fast = ''
      animations = (
        {
          triggers = [ "open" ];
          preset = "appear";
          scale = 1.03;
          duration = 0.10;
        },
        {
          triggers = [ "close" ];
          preset = "disappear";
          scale = 1.03;
          duration = 0.08;
        },
        {
          triggers = [ "show" ];
          preset = "slide-in";
          direction = "up";
          duration = 0.08;
        },
        {
          triggers = [ "hide" ];
          preset = "slide-out";
          direction = "down";
          duration = 0.08;
        }
      );
    '';

    veryFast = ''
      animations = (
        {
          triggers = [ "open" ];
          preset = "appear";
          scale = 1.02;
          duration = 0.07;
        },
        {
          triggers = [ "close" ];
          preset = "disappear";
          scale = 1.02;
          duration = 0.06;
        },
        {
          triggers = [ "show" ];
          preset = "slide-in";
          direction = "up";
          duration = 0.06;
        },
        {
          triggers = [ "hide" ];
          preset = "slide-out";
          direction = "down";
          duration = 0.06;
        }
      );
    '';
  };

  chosenProfile = animationProfiles.veryFast;

  picomConfig = pkgs.writeText "picom.conf" ''
    backend = "glx";
    vsync = true;
    use-damage = true;
    unredir-if-possible = false;

    shadow = true;
    shadow-radius = 18;
    shadow-opacity = 0.32;
    shadow-offset-x = -12;
    shadow-offset-y = -12;
    corner-radius = 12;

    blur: {
      method = "gaussian";
      size = 12;
      deviation = 4.0;
    };

    ${chosenProfile}

    rules = (
      {
        match = "window_type = 'dock' || window_type = 'desktop'";
        shadow = false;
        blur-background = false;
      },
      {
        match = "fullscreen";
        corner-radius = 0;
        shadow = false;
      },
      {
        match = "window_type *= 'dropdown_menu' || window_type *= 'popup_menu' || window_type *= 'tooltip'";
        blur-background = false;
        shadow = false;
      },
      {
        match = "class_g *?= 'Rofi' || class_g *?= 'wofi' || class_g *?= 'dunst'";
        blur-background = false;
        shadow = false;
      },
      {
        match = "class_g = 'Alacritty' || class_g = 'kitty' || class_g = 'foot'";
        opacity = 0.98;
      }
    );
  '';
in
{
  services.picom = {
    enable = true;
    package = pkgs.picom;
    backend = "glx";
    vSync = true;
  };

  systemd.user.services.picom.serviceConfig.ExecStart =
    lib.mkForce "${lib.getExe pkgs.picom} --config ${picomConfig}";
}
