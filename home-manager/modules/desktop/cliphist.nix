{ config, lib, ... }:
{
  config = lib.mkIf config.local.desktop.cliphist.enable {
    services.cliphist = {
      enable = true;
      allowImages = true;
      extraOptions = [
        "-max-dedupe-search"
        "10"
        "-max-items"
        "500"
      ];
    };
  };
}
