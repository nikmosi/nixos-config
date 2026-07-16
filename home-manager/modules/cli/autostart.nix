{
  config,
  hostConfig,
  lib,
  ...
}:
{
  config =
    lib.mkIf (config.local.cli.autostart.enable && (hostConfig.nik.hardware.gpu or "none") == "nvidia")
      {
        xdg.configFile."autostart/hyperhdr.desktop" = {
          force = true;
          text = ''
            [Desktop Entry]
            Type=Application
            Name=HyperHDR
            Comment=HyperHDR startup
            Exec=hyperhdr
            StartupNotify=false
            Terminal=false
          '';
        };
      };
}
