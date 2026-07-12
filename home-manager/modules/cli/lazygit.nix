{ config, lib, ... }:
{
  config = lib.mkIf config.local.cli.lazygit.enable {
    programs.lazygit = {
      enable = true;
      settings = {
        gui.showIcons = true;
        gui.theme = {
          lightTheme = false;
          activeBorderColor = [
            "green"
            "bold"
          ];
          inactiveBorderColor = [ "grey" ];
          selectedLineBgColor = [ "blue" ];
        };
      };
    };
  };
}
