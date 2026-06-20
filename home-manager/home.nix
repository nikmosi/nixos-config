{ userSettings, ... }:
{
  imports = [
    ./modules
    ./21-packages.nix
    ./packages-stable.nix
    ./packages-unstable.nix
  ];
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "electron-38.8.4" ];
  };
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
