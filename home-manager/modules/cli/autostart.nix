_: {
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
}
