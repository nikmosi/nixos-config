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

    jellyfin-mpv-shim

    # 🧠 Development Tools
    prettier
    prettierd
    unstable.codex
    unstable.antigravity-fhs
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
    uv
    vscode
    topiary
    pv
    hadolint
    minikube
    kubectl
    kubecm
    typst
    terraform
    ansible
    kubernetes-helm
    kustomize

    # 💻 System / CLI Utilities

    handbrake
    v2rayn
    proxychains-ng
    rename
    sshs
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

    ## Rust

    dust
    bottom
    zenith
    procs
    hyperfine
    dysk
    gping
    monolith
    dog
    tealdeer
    broot
    trash-cli
    sd
    hexyl

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
    unstable.yt-dlp
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

    # linters

    actionlint
    ansible-lint
    eslint
    eslint_d
    gitlint
    hadolint
    ktlint
    markdownlint-cli2
    markuplinkchecker
    shellcheck
    deadnix
    statix
    oxlint
    proselint
    protolint
    pylint
    stylelint
    tflint
    yamllint
    vale
    tombi
    checkmake
    htmlhint
    stylelint
    kubeconform
    kubeval

    # 🧰 Language Servers / LSP
    tofu-ls
    bandit
    terraform-ls
    ansible-lint
    helm-ls
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
    unstable.ty
    yaml-language-server

    # 🪟 GUI Applications
    librewolf
    discord
    vesktop
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
    telegrams.packages.${pkgs.stdenv.hostPlatform.system}.ayugram-desktop
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
