{ pkgs, config, ... }:
{
  programs = {
    nh = {
      enable = true;
      clean.enable = false;
      flake = "${config.users.users.nik.home}/.flake";
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
