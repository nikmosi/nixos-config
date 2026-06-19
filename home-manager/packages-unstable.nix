{ unstable, ... }:
{

  home.packages = with unstable; [

    # 🤖 AI / Agents
    opencode
    forgejo-mcp
    codex
    gemini-cli
    antigravity-fhs
    freelens-bin
    lens
    ty

    # 🧪 Linters
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
    kubeconform
    kubeval

    # 🧰 Language Servers / LSP
    tofu-ls
    bandit
    terraform-ls
    helm-ls
    sqruff
    bash-language-server
    docker-compose-language-service
    dockerfile-language-server
    fish-lsp
    harper
    lua-language-server
    nginx-language-server
    nil
    nixd
    pyright
    python312Packages.python-lsp-server
    ruff
    yaml-language-server

    # Formatters
    nixfmt
    nginx-config-formatter

    # 🦀 Rust ecosystem
    btop
    zenith
    procs
    hyperfine
    dysk
    monolith
    dog
    tealdeer
    broot
    sd
    hexyl
    microfetch
    mediainfo
    dua
    ffmpegthumbnailer
    silicon

    # ⚡ CLI Tools (fast-moving)
    fluxcd
    navi
    ripdrag
    xh
    httpie
    translate-shell
    zbar
    croc
    curtail
    sesh
    bemoji
    ueberzugpp
    prek

    # 🧠 Development Tools
    insomnia
    devenv
    typst
    minikube
    kubectl
    kubecm
    terraform
    ansible
    kubernetes-helm
    pgcli

    # 💻 System TUI
    systemctl-tui
    lazyjournal
    lazysql

    # 📦 Other
    tea
    blanket

    # 🎥 Media downloaders
    yt-dlp
  ];
}
