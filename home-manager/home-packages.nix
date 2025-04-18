{
  pkgs,
  telegrams,
  unstable,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    hyperhdr
    prismlauncher
    nekoray

    chatterino2
    easyeffects
    vial
    imv
    mpv
    obsidian
    telegrams.packages.${pkgs.system}.ayugram-desktop
    qbittorrent-enhanced
    pavucontrol
    lmstudio

    # CLI utils
    alsa-utils
    steam-run-free
    direnv
    devenv
    sesh
    unstable.neovim
    sshs
    lazydocker
    cachix
    xh
    httpie
    git-extras
    gh
    translate-shell
    btop
    ffmpeg
    ffmpegthumbnailer
    fzf
    mediainfo
    microfetch
    playerctl
    ripgrep
    silicon
    mimeo
    udisks
    ueberzugpp
    unzip
    yt-dlp
    zip
    bemoji
    nix-prefetch-scripts
    ripdrag
    stylua

    # fonts
    roboto
    weather-icons
    material-icons
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
      ];
    })
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    weather-icons
    source-code-pro

    # pass
    passff-host

    rofi-pass
    rofi-power-menu

    maim
    stow
    zbar
    zoxide

    # lsp
    harper
    docker-compose-language-service
    nginx-language-server
    yaml-language-server
    dockerfile-language-server-nodejs
    lua-language-server
    nil
    pyright
    python312Packages.python-lsp-server
    ruff
    nixd
  ];

}
