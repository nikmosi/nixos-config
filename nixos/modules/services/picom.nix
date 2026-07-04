{
  config,
  lib,
  pkgs,
  ...
}:

let
  mkAnimationProfile =
    {
      openDuration,
      closeDuration,
      showDuration,
      hideDuration,
      openScale,
      openOffsetFactor,
      hiddenScale,
      hiddenOffsetFactor,
    }:
    ''
      animations = (
        {
          triggers = [ "open" ];

          opacity = {
            curve = "cubic-bezier(0.16, 1, 0.3, 1)";
            duration = ${openDuration};
            start = 0;
            end = "window-raw-opacity";
          };
          scale-x = {
            curve = "cubic-bezier(0.22, 1.35, 0.36, 1)";
            duration = ${openDuration};
            start = ${openScale};
            end = 1;
          };
          scale-y = "scale-x";
          offset-x = {
            curve = "cubic-bezier(0.22, 1.35, 0.36, 1)";
            duration = ${openDuration};
            start = "window-width * ${openOffsetFactor}";
            end = 0;
          };
          offset-y = {
            curve = "cubic-bezier(0.22, 1.35, 0.36, 1)";
            duration = ${openDuration};
            start = "window-height * ${openOffsetFactor} + 12";
            end = 0;
          };
          shadow-scale-x = "scale-x";
          shadow-scale-y = "scale-y";
          shadow-offset-x = "offset-x";
          shadow-offset-y = "offset-y";
        },
        {
          triggers = [ "close" ];

          opacity = {
            curve = "cubic-bezier(0.7, 0, 0.84, 0)";
            duration = ${closeDuration};
            start = "window-raw-opacity-before";
            end = 0;
          };
          scale-x = {
            curve = "cubic-bezier(0.7, 0, 0.84, 0)";
            duration = ${closeDuration};
            start = 1;
            end = ${hiddenScale};
          };
          scale-y = "scale-x";
          offset-x = {
            curve = "cubic-bezier(0.7, 0, 0.84, 0)";
            duration = ${closeDuration};
            start = 0;
            end = "window-width * ${hiddenOffsetFactor}";
          };
          offset-y = {
            curve = "cubic-bezier(0.7, 0, 0.84, 0)";
            duration = ${closeDuration};
            start = 0;
            end = "window-height * ${hiddenOffsetFactor} + 10";
          };
          shadow-scale-x = "scale-x";
          shadow-scale-y = "scale-y";
          shadow-offset-x = "offset-x";
          shadow-offset-y = "offset-y";
        },
        {
          triggers = [ "show" ];

          opacity = {
            curve = "cubic-bezier(0.16, 1, 0.3, 1)";
            duration = ${showDuration};
            start = 0;
            end = "window-raw-opacity";
          };
          scale-x = {
            curve = "cubic-bezier(0.16, 1, 0.3, 1)";
            duration = ${showDuration};
            start = ${hiddenScale};
            end = 1;
          };
          scale-y = "scale-x";
          offset-x = {
            curve = "cubic-bezier(0.16, 1, 0.3, 1)";
            duration = ${showDuration};
            start = "window-width * ${hiddenOffsetFactor}";
            end = 0;
          };
          offset-y = {
            curve = "cubic-bezier(0.16, 1, 0.3, 1)";
            duration = ${showDuration};
            start = "window-height * ${hiddenOffsetFactor} + 16";
            end = 0;
          };
          shadow-scale-x = "scale-x";
          shadow-scale-y = "scale-y";
          shadow-offset-x = "offset-x";
          shadow-offset-y = "offset-y";
        },
        {
          triggers = [ "hide" ];

          opacity = {
            curve = "cubic-bezier(0.7, 0, 0.84, 0)";
            duration = ${hideDuration};
            start = "window-raw-opacity-before";
            end = 0;
          };
          scale-x = {
            curve = "cubic-bezier(0.7, 0, 0.84, 0)";
            duration = ${hideDuration};
            start = 1;
            end = ${hiddenScale};
          };
          scale-y = "scale-x";
          offset-x = {
            curve = "cubic-bezier(0.7, 0, 0.84, 0)";
            duration = ${hideDuration};
            start = 0;
            end = "window-width * ${hiddenOffsetFactor}";
          };
          offset-y = {
            curve = "cubic-bezier(0.7, 0, 0.84, 0)";
            duration = ${hideDuration};
            start = 0;
            end = "window-height * ${hiddenOffsetFactor} + 16";
          };
          shadow-scale-x = "scale-x";
          shadow-scale-y = "scale-y";
          shadow-offset-x = "offset-x";
          shadow-offset-y = "offset-y";
        }
      );
    '';

  animationProfiles = {
    fast = mkAnimationProfile {
      openDuration = "0.10";
      closeDuration = "0.08";
      showDuration = "0.08";
      hideDuration = "0.08";
      openScale = "0.92";
      openOffsetFactor = "0.04";
      hiddenScale = "0.95";
      hiddenOffsetFactor = "0.025";
    };

    veryFast = mkAnimationProfile {
      openDuration = "0.07";
      closeDuration = "0.06";
      showDuration = "0.06";
      hideDuration = "0.06";
      openScale = "0.90";
      openOffsetFactor = "0.05";
      hiddenScale = "0.94";
      hiddenOffsetFactor = "0.03";
    };
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
        match = "_PICOM_SINGLE_TILED@ = 1";
        corner-radius = 0;
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
        match = "class_g ?= 'slop' || class_i ?= 'slop' || name ?= 'slop'";
        blur-background = false;
        shadow = false;
        corner-radius = 0;
      },
      {
        match = "class_g = 'Alacritty' || class_g = 'kitty' || class_g = 'foot'";
        opacity = 0.98;
      }
    );
  '';
in
lib.mkIf (config.nik.display.backend == "x11") {
  services.picom = {
    enable = true;
    package = pkgs.picom;
    backend = "glx";
    vSync = true;
  };

  systemd.user.services.picom.serviceConfig.ExecStart =
    lib.mkForce "${lib.getExe pkgs.picom} --config ${picomConfig}";
}
