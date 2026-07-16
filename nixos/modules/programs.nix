{
  pkgs,
  config,
  userSettings,
  ...
}:
{
  programs = {
    nh = {
      enable = true;
      clean.enable = false;
      flake = "${config.users.users.${userSettings.username}.home}/.flake";
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
