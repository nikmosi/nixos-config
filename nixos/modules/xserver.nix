{ qtileDeps, ... }:
{
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    displayManager = {
      lightdm.enable = true;
      startx.enable = true;
      sessionCommands = ''
        xrandr --output DP-0 --mode 2560x1440 --rate 165
      '';
    };

    # Configure keymap in X11
    xkb.layout = "us";
    windowManager.qtile = {
      enable = true;
      extraPackages = python312Packages: qtileDeps;
    };
  };
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
}
