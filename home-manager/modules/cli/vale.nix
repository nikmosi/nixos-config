{ config, lib, ... }:
{
  config = lib.mkIf config.local.cli.vale.enable {
    xdg.configFile."vale/.vale.ini" = {
      force = true;
      text = ''
        StylesPath = styles
        MinAlertLevel = suggestion
        Packages = write-good

        [*.md]
        BasedOnStyles = write-good
      '';
    };
  };
}
