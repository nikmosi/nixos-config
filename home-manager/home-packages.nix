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

    yandex-disk
    localsend
    navi
    unstable.opencode
    jetbrains.datagrip
    systemctl-tui
    lazyjournal
    lazysql
    playwright
    playwright-driver
    playwright-mcp
    lens
    wakatime-cli
    tea
    curtail
    croc
    models-dev
    zotero
    blanket
    thunderbird

    # 🧠 Development Tools
    unstable.codex
    unstable.antigravity-fhs
    unstable.gemini-cli
    insomnia
    devenv
    libgcc
    license-cli
    openjdk17
    pgcli
    stylua
    tokei
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

    # 💻 System / CLI Utilities

    handbrake
    translate-shell
    zbar

    ## 🧠 System Monitoring & Info
    btop
    microfetch
    mediainfo
    dua
    ffmpegthumbnailer
    silicon

    ## Rust

    zenith
    procs
    hyperfine
    dysk
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
    bemoji
    ueberzugpp
    ripdrag

    ## 🔗 Networking & Proxy
    sshs
    sshuttle
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
    discord
    vesktop
    feh
    hyperhdr
    imv
    lmstudio
    meld
    obs-studio
    obsidian
    pavucontrol
    prismlauncher
    qbittorrent-enhanced
    telegrams.packages.${pkgs.stdenv.hostPlatform.system}.ayugram-desktop
    vial

    # 🧾 Custom GUI Scripts
    pkgs.chatterino2

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
