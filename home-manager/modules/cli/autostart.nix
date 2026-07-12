{ config, lib, ... }:
{
  config = lib.mkIf config.local.cli.autostart.enable {
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
