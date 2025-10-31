{
  pkgs,
  telegrams,
  unstable,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [

    # 🧠 Development Tools
    devenv
    gcc
    glib
    lazycli
    lazysql
    libgcc
    license-cli
    lua
    nodejs
    openjdk17
    pgcli
    stylua
    tokei
    unstable.neovim
    uv
    vscode

    # 💻 System / CLI Utilities

    ## 🧠 System Monitoring & Info
    btop
    microfetch
    mediainfo
    ncdu
    ffmpegthumbnailer
    silicon

    ## ⚙️ System Management
    alsa-utils
    udisks
    cpulimit
    direnv
    stow
    nix-prefetch-scripts
    cachix

    ## 🧩 File & Archive Tools
    unzip
    zip
    unrar
    rename
    rmlint
    diffutils
    file
    mimeo
    chafa

    ## 🪄 Terminal Enhancements
    warp-terminal
    fzf
    sesh
    translate-shell
    tldr
    bemoji
    ueberzugpp
    ripdrag

    ## 🔗 Networking & Proxy
    sshs
    sshuttle
    proxychains-ng
    httpie
    xh

    ## 🎥 Media & Screenshot
    ffmpeg
    maim
    playerctl
    yt-dlp

    ## 🧰 Dev Utilities
    gh
    git-extras
    git-lfs
    glib
    jqp
    lima

    # 🧩 DevOps / Containers
    cachix
    docker-compose-language-service
    dockerfile-language-server-nodejs
    gh
    glab
    lima
    qemu

    # 🧰 Language Servers / LSP
    actionlint
    bash-language-server
    docker-compose-language-service
    dockerfile-language-server-nodejs
    fish-lsp
    harper
    lua-language-server
    nginx-config-formatter
    nginx-language-server
    nil
    nixd
    pyright
    python312Packages.python-lsp-server
    ruff
    ty
    yaml-language-server

    # 🪟 GUI Applications
    chromium
    discord
    drawio
    easyeffects
    element-desktop
    feh
    hiddify-app
    hyperhdr
    imv
    lmstudio
    meld
    nekoray
    obs-studio
    obsidian
    pavucontrol
    pomodoro-gtk
    postman
    prismlauncher
    qbittorrent-enhanced
    telegrams.packages.${pkgs.system}.ayugram-desktop
    vial

    # 🧾 Custom GUI Scripts
    (pkgs.writeShellScriptBin "chatterino" ''
      #!/usr/bin/env bash
      ${pkgs.proxychains-ng}/bin/proxychains4 ${pkgs.chatterino2}/bin/chatterino "$@"
    '')
    (pkgs.writeShellScriptBin "ModrinthApp" ''
      #!/usr/bin/env bash
      export WEBKIT_DISABLE_DMABUF_RENDERER=1
      ${pkgs.modrinth-app}/bin/ModrinthApp "$@"
    '')

    # 🎮 Gaming / Graphics
    gamemode
    gamescope
    steam-run-free

    # 🔠 Fonts
    material-icons
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    roboto
    source-code-pro
    weather-icons

    # 🦇 Bat Extras
    bat-extras.batdiff
    bat-extras.batgrep
    bat-extras.batman
    bat-extras.batpipe
    bat-extras.batwatch
    bat-extras.prettybat

    # 🔐 Pass / Rofi
    passff-host
    rofi-pass
    rofi-power-menu

    # 🧹 Misc / Formatting
    unstable.nixfmt
    nginx-config-formatter

  ];

}
