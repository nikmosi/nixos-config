{ config, lib, ... }:
{
  config = lib.mkIf config.local.cli.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
    };
  };
}
