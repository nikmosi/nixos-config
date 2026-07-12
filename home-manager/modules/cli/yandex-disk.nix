{ config, lib, ... }:
{
  config = lib.mkIf config.local.cli.yandex-disk.enable {
    xdg.configFile."yandex-disk/config.cfg" = {
      force = true;
      text = ''
        auth="${config.xdg.configHome}/yandex-disk/passwd"
        dir="${config.home.homeDirectory}/Yandex.Disk"
        proxy="no"
      '';
    };
  };
}
