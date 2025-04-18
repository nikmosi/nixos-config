{
  pkgs,
  telegrams,
  unstable,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # gui
    chatterino2
    easyeffects
    hyperhdr
    imv
    lmstudio
    mpv
    nekoray
    obsidian
    pavucontrol
    prismlauncher
    qbittorrent-enhanced
    telegrams.packages.${pkgs.system}.ayugram-desktop
    vial

    # CLI utils
    alsa-utils
    bemoji
    btop
    cachix
    devenv
    direnv
    ffmpeg
    ffmpegthumbnailer
    fzf
    gh
    git-extras
    httpie
    lazydocker
    maim
    mediainfo
    microfetch
    mimeo
    nix-prefetch-scripts
    playerctl
    ripdrag
    sesh
    silicon
    sshs
    steam-run-free
    stow
    stylua
    translate-shell
    udisks
    ueberzugpp
    unstable.neovim
    unzip
    xh
    yt-dlp
    zbar
    zip
    zoxide

    # fonts
    material-icons
    roboto
    weather-icons
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
      ];
    })
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    source-code-pro
    weather-icons

    # pass
    passff-host
    rofi-pass
    rofi-power-menu

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
