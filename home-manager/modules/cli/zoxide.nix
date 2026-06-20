{ pkgs, ... }:
{
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
    enableFishIntegration = true;
    package = pkgs.unstable.zoxide;
  };
}
