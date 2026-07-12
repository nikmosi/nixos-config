{ config, lib, ... }:
{
  config = lib.mkIf config.local.cli.yt-dlp.enable {
    xdg.configFile."yt-dlp/config".text = ''
      --mtime
    '';
  };
}
