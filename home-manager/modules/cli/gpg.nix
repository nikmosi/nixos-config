{
  programs.gpg.enable = true;
  services.ssh-agent.enable = false;

  services.gpg-agent = {
    enable = true;

    enableSshSupport = true;

    defaultCacheTtl = 7200;
    maxCacheTtl = 86400;
    extraConfig = ''
      allow-preset-passphrase
    '';

    # pinentryPackage = pkgs.pinentry-gnome3; # или pkgs.pinentry-qt / pkgs.pinentry-curses
  };

  home.file.".pam-gnupg".text = ''
    7A66CC1C82953776FE2E80FBBE0C403B9C2E4485
    4CE6DA1AD68834E91CCB66E1386DEA05B047011F
    F0932A3122EAD7F16739035863EC63CD50ED3ACF
    C6C59CAFC8531B4B480183C89C8CFF61049A24F7
  '';
}
