{ pkgs, ... }:
{
  programs = {
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 3";
      flake = "/home/nik/.flake";
    };

    nix-index = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-rofi;
    };

    fish = {
      enable = true;
    };
  };
}
