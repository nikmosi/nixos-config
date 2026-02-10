{
  programs.gpg.enable = true;
  services.ssh-agent.enable = false;

  services.gpg-agent = {
    enable = true;

    enableSshSupport = true;

    defaultCacheTtl = 7200;
    maxCacheTtl = 86400;

    # pinentryPackage = pkgs.pinentry-gnome3; # или pkgs.pinentry-qt / pkgs.pinentry-curses
  };
}
