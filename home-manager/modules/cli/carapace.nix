{ config, lib, ... }:
{
  config = lib.mkIf config.local.cli.carapace.enable {
    programs.carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
