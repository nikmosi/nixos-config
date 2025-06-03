{
  imports = [
    ./modules
    ./home-packages.nix
  ];
  home.username = "nik";
  home.homeDirectory = "/home/nik";
  home.stateVersion = "25.05";

  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
