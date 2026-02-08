{ unstable, ... }:
{
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
    enableFishIntegration = true;
    package = unstable.zoxide;
  };
}
