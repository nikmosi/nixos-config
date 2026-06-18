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
}
