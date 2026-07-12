{
  userSettings,
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.local.desktop.rofi-pass.enable {
    xdg.configFile."rofi-pass/config".text = ''
      backend=wtype
      clipboard_backend=wl-clipboard
      type_delay=6
      default_user=${userSettings.username}
      password_length=32
    '';
  };
}
