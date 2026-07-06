_: {
  xdg.configFile."autostart/localsend_app.desktop" = {
    force = true;
    text = ''
      [Desktop Entry]
      Type=Application
      Name=localsend_app
      Comment=localsend_app startup script
      Exec=localsend_app --hidden
      StartupNotify=false
      Terminal=false
    '';
  };

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
