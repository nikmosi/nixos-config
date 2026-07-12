{
  config,
  lib,
  ...
}:

lib.mkIf (config.nik.display.backend == "x11") {
  hardware.nvidia.forceFullCompositionPipeline = true;

  services.xserver = {
    enable = true;

    xkb.layout = "us";
    extraConfig =
      let
        monitors = config.nik.monitors;
        # Build metamodes string from monitor config
        metamodes = lib.concatStringsSep ", " (
          map (
            m:
            "${m.name}: 2560x1440 +${toString m.x}+${toString m.y} {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On, AllowGSYNCCompatible=On}"
          ) monitors
        );
      in
      ''
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
            Option         "metamodes" "${metamodes}"
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
