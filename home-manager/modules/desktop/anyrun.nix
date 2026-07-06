{ pkgs, inputs, ... }:
{
  programs.anyrun = {
    enable = true;
    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        symbols
        rink
        stdin
        kidex
        niri-focus
      ];
      x = {
        fraction = 0.5;
      };
      y = {
        fraction = 0.0;
      };
      width = {
        fraction = 0.3;
      };
      height = {
        absolute = 1;
      };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = false;
      showResultsImmediately = false;
      maxEntries = null;
    };
  };

}
