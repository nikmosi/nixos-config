{ userSettings, ... }:
{
  imports = [
    ./modules
    ./home-packages.nix
  ];
  xdg.enable = true;
  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";
  home.stateVersion = "25.05";

  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
