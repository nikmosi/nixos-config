{
  services.xserver.displayManager = {
    lightdm = {
      enable = true;
      greeter = {
        enable = true;
      };
      greeters = {
        slick = {
          enable = true;
        };
      };
    };
    sessionCommands = ''
      xrandr --output DP-2 --mode 2560x1440 --rate 165 --pos 2560x0 \
      --output DP-0 --mode 2560x1440 --rate 165 --pos 0x0 --primary;
      xrandr --output DP-0 --left-of DP-2;
    '';

    startx.enable = true;
  };
}
