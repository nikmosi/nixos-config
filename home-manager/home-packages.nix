{
  pkgs,
  telegrams,
  unstable,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    alsa-utils
    direnv
    devenv
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
    nufmt
    carapace
    sesh
    unstable.neovim
    sshs
    git-lfs
    lazydocker
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
    pinentry-rofi
    fzf
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
