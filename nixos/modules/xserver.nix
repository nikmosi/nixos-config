{ qtileDeps, ... }:
{
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    displayManager = {
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
      startx.enable = true;
      setupCommands = ''
        xrandr --output DP-2 --mode 2560x1440 --rate 165 --pos 2560x0 --primary \
        --output DP-0 --mode 2560x1440 --rate 165 --pos 0x0;
      '';
    };
    extraConfig = ''
      Section "ServerLayout"
        Identifier     "Layout0"
        Screen      0  "Screen0" 0 0
        InputDevice    "Keyboard0" "CoreKeyboard"
        InputDevice    "Mouse0" "CorePointer"
        Option         "Xinerama" "0"
      EndSection

      Section "Screen"
        Identifier     "Screen0"
        Device         "Device0"
        Monitor        "Monitor0"
        DefaultDepth    24
        Option         "Stereo" "0"
        Option         "nvidiaXineramaInfoOrder" "DP-0"
        Option         "metamodes" "DP-2: 2560x1440_165 +2560+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On, AllowGSYNCCompatible=On}, DP-0: 2560x1440_165 +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On, AllowGSYNCCompatible=On}"
        Option         "SLI" "Off"
        Option         "MultiGPU" "Off"
        Option         "BaseMosaic" "off"
        SubSection     "Display"
            Depth       24
        EndSubSection
      EndSection

      Section "Monitor"
        # HorizSync source: edid, VertRefresh source: edid
        Identifier     "Monitor0"
        VendorName     "Unknown"
        ModelName      "Philips PHL32M1N5500V"
        HorizSync       250.0 - 250.0
        VertRefresh     48.0 - 165.0
        Option         "DPMS"
      EndSection
    '';

    # Configure keymap in X11
    xkb.layout = "us";
    windowManager.qtile = {
      enable = true;
      extraPackages = python312Packages: qtileDeps;
    };
  };
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
}
