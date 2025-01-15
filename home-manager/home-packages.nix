{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    steam-run-free

    imv
    mpv
    obsidian
    vesktop

    # CLI utils
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
    pre-commit
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
