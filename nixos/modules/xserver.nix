{ qtileDeps, ... }:
{
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    libinput.enable = true;
    libinput.accelProfile = "flat";
    displayManager = {
      lightdm.enable = true;
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
