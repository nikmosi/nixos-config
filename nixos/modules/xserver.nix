{
  imports = [
    ./wms/awesome.nix
    ./wms/qtile.nix
    ./dms/lightdm.nix
  ];

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];

    # Configure keymap in X11
    xkb.layout = "us";
    extraConfig = ''
      Section "Monitor"
          # HorizSync source: edid, VertRefresh source: edid
          Identifier     "Monitor0"
          VendorName     "Unknown"
          ModelName      "Philips PHL32M1N5500V"
          HorizSync       250.0 - 250.0
          VertRefresh     48.0 - 165.0
          Option         "DPMS"
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
    '';
  };
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
}
