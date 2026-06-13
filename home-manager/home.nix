{ userSettings, ... }:
{
  imports = [
    ./modules
    ./home-packages.nix
  ];
  xdg.enable = true;
  home = {
    inherit (userSettings) username;
    homeDirectory = "/home/${userSettings.username}";
    stateVersion = userSettings.homeStateVersion;
  };

  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
