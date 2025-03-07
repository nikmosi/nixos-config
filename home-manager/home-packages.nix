{
  pkgs,
  telegrams,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    (dmenu.overrideAttrs (old: {
      patches = [
        # Center patch
        (pkgs.fetchpatch {
          url = "https://tools.suckless.org/dmenu/patches/center/dmenu-center-5.2.diff";
          sha256 = "sha256-g7ow7GVUsisR2kQ4dANRx/pJGU8fiG4fR08ZkbUFD5o=";
        })
        # Line height patch
        (pkgs.fetchpatch {
          url = "https://tools.suckless.org/dmenu/patches/line-height/dmenu-lineheight-5.2.diff";
          sha256 = "sha256-QdY2T/hvFuQb4NAK7yfBgBrz7Ii7O7QmUv0BvVOdf00=";
        })
      ];
    }))

    nekoray
    steam-run-free

    chatterino2
    easyeffects
    vial
    imv
    mpv
    obsidian
    telegrams.packages.${pkgs.system}.ayugram-desktop
    vesktop
    qbittorrent-enhanced
    pavucontrol
    lmstudio

    # CLI utils
    jupyter-all
    cachix
    xh
    httpie
    git-extras
    gcc
    clang-tools
    gh
    translate-shell
    btop
    bottom
    brightnessctl
    ffmpeg
    ffmpegthumbnailer
    fzf
    git-graph
    mediainfo
    microfetch
    playerctl
    ripgrep
    showmethekey
    silicon
    mimeo
    udisks
    ueberzugpp
    unzip
    yt-dlp
    zip
    bemoji
    nix-prefetch-scripts

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
    pinentry-rofi
    fzf
    maim
    stow
    zbar
    zoxide

    # lsp
    docker-compose-language-service
    docker-ls
    lua-language-server
    nil
    pyright
    python312Packages.python-lsp-server
    ripdrag
    ruff
  ];

}
