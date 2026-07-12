{
  config,
  lib,
  ...
}:

lib.mkIf (config.nik.display.backend == "x11") {
  services.xserver.displayManager = {
    lightdm = {
      enable = true;
      greeter = {
        enable = true;
      };
      greeters = {
        slick = {
          enable = true;
          extraConfig = ''
            background=${../../assets/wallpapers/lightdm.png}
          '';
        };
      };
    };
    sessionCommands =
      let
        monitors = config.nik.monitors;
        m0 = builtins.head monitors;
        m1 = builtins.elemAt monitors 1;
      in
      ''
        xrandr --output ${m1.name} --mode 2560x1440 --rate 165 --pos ${toString m1.x}+${toString m1.y} \
        --output ${m0.name} --mode 2560x1440 --rate 165 --pos ${toString m0.x}+${toString m0.y} --primary;
        xrandr --output ${m0.name} --left-of ${m1.name};
      '';

    startx.enable = true;
  };
}
