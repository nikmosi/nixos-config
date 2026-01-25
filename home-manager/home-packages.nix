{
  pkgs,
  telegrams,
  unstable,
  ...
}:
{
  imports = [ ./21-packages.nix ];
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [

    # 🧠 Development Tools
    unstable.codex
    antigravity-fhs
    gemini-cli
    yarn
    insomnia
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
    topiary

    # 💻 System / CLI Utilities

    v2rayn
    proxychains-ng
    rename
    sshs
    tldr
    translate-shell
    udisks
    ueberzugpp
    unrar
    warp-terminal
    zbar
    # serie
    zip

    ## 🧠 System Monitoring & Info
    btop
    microfetch
    mediainfo
    dua
    ffmpegthumbnailer
    silicon

    ## ⚙️ System Management
    alsa-utils
    udisks
    cpulimit
    direnv
    stow
    nix-prefetch-scripts

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
    libreoffice-fresh
    hunspell
    hyphen

    ## 🧰 Dev Utilities
    gh
    git-extras
    git-lfs
    glib
    jqp

    # 🧩 DevOps / Containers
    cachix
    docker-compose-language-service
    dockerfile-language-server
    gh
    glab
    qemu

    # 🧰 Language Servers / LSP
    sqruff
    actionlint
    bash-language-server
    docker-compose-language-service
    dockerfile-language-server
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
    librewolf
    discord
    drawio
    easyeffects
    feh
    hyperhdr
    imv
    lmstudio
    meld
    obs-studio
    obsidian
    pavucontrol
    postman
    prismlauncher
    qbittorrent-enhanced
    telegrams.packages.${pkgs.system}.ayugram-desktop
    vial

    # 🧾 Custom GUI Scripts
    pkgs.chatterino2
    # (pkgs.writeShellScriptBin "ModrinthApp" ''
    #   #!/usr/bin/env bash
    #   export WEBKIT_DISABLE_DMABUF_RENDERER=1
    #   ${pkgs.modrinth-app-unwrapped}/bin/ModrinthApp "$@"
    # '')

    # 🎮 Gaming / Graphics
    gamemode
    gamescope
    steam-run-free
    wineWow64Packages.full

    # 🔠 Fonts
    material-icons
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
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
