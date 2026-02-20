{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 3";
    flake = "/home/nik/.flake";
  };

  programs.nix-index.enable = true;
  programs.nix-index.enableBashIntegration = false;
  programs.nix-index.enableZshIntegration = false;
  programs.command-not-found.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-qt;

  };

  programs.fish = {
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

}
