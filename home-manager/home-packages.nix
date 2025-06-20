{
  pkgs,
  telegrams,
  unstable,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    unrar
    nodejs
    serie

    # gui
    (pkgs.writeShellScriptBin "chatterino" ''
      #!/usr/bin/env bash
      ${pkgs.proxychains-ng}/bin/proxychains4 ${pkgs.chatterino2}/bin/chatterino  "$@"
    '')

    (pkgs.writeShellScriptBin "ModrinthApp" ''
      #!/usr/bin/env bash
      export WEBKIT_DISABLE_DMABUF_RENDERER=1
      ${pkgs.modrinth-app}/bin/ModrinthApp "$@"
    '')
    easyeffects
    hyperhdr
    imv
    lmstudio
    pomodoro-gtk
    nekoray
    obsidian
    pavucontrol
    prismlauncher
    qbittorrent-enhanced
    telegrams.packages.${pkgs.system}.ayugram-desktop
    vial
    element-desktop

    # CLI utils
    proxychains-ng
    gamemode
    gamescope
    devenv
    android-tools
    diffutils
    uv
    lima
    qemu
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
    lua
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

    # fonts
    material-icons
    roboto
    weather-icons
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    source-code-pro
    weather-icons

    # bat-extras
    bat-extras.batman
    bat-extras.prettybat
    bat-extras.batwatch
    bat-extras.batpipe
    bat-extras.batgrep
    bat-extras.batdiff

    # pass
    passff-host
    rofi-pass
    rofi-power-menu

    # lsp
    nginx-config-formatter
    fish-lsp
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
    ty
  ];

}
