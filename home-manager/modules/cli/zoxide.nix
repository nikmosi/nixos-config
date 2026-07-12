{
  pkgs,
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.local.cli.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableNushellIntegration = true;
      enableFishIntegration = true;
      package = pkgs.unstable.zoxide;
    };
  };
}
