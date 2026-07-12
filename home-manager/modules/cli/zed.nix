{ config, lib, ... }:
{
  config = lib.mkIf config.local.cli.zed.enable {
    xdg.configFile."zed/settings.json" = {
      force = true;
      text = ''
        {
          "ui_font_size": 16,
          "buffer_font_size": 16,
          "theme": {
            "mode": "system",
            "light": "One Light",
            "dark": "One Dark"
          }
        }
      '';
    };
  };
}
