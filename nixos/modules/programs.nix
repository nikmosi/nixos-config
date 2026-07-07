{ pkgs, ... }:
{
  programs = {
    firefox = {
      enable = true;
    };

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
    command-not-found.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-rofi;

    };

    fish = {
      enable = true;
      shellAliases = {
        l = null;
        ll = null;
        ls = null;
        v = "nvim";
        se = "sudoedit";
        sw = "nh os switch";
        upd = "nh os switch --update";
        hms = "nh home switch";
      };
    };
  };
}
