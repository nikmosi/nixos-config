{
  pkgs,
  telegrams,
  ...
}:
{
  home.packages =
    ## ---- UNSTABLE -----
    (with pkgs.unstable; [

      # 🤖 AI / Agents
      opencode
      forgejo-mcp
      codex
      gemini-cli
      antigravity-fhs
      freelens-bin
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
      fluxcd-operator
      kubecolor
      kubectx
      kube-score
      kubectl-explore
      kube-capacity
      kubent
      krew
      handy
      pi-coding-agent
      nodejs

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
    ])

    ## ---- STABELE -----
    ++ (
      with pkgs;
      [
        # 🪟 GUI Applications
        super-productivity
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
        vial
        chatterino2
        zotero
        thunderbird
        weave-gitops
        rustdesk

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

        # ⚙️ System Management
        alsa-utils
        udisks
        cpulimit
        direnv
        stow
        nix-prefetch-scripts

        # 🧩 File & Archive Tools
        unzip
        zip
        unrar
        rename
        rmlint
        diffutils
        file
        mimeo
        chafa
        trash-cli

        # 🎥 Media & Screenshot
        ffmpeg
        maim
        playerctl
        libreoffice-fresh
        hunspell
        hyphen
        handbrake

        # 🧰 Dev Utilities
        jetbrains.datagrip
        playwright
        playwright-driver
        playwright-mcp
        openssl
        libgcc
        license-cli
        openjdk17
        qemu
        cachix
        glib
        jqp
        gh
        git-extras
        git-lfs
        glab
        stylua
        tokei
        topiary
        pv

        # 🌐 Networking & Proxy
        sshs
        sshuttle

        # 📦 Other
        yandex-disk
        localsend
        wakatime-cli
        models-dev

        # 🪟 Wayland utilities
        swaylock
        swayidle
        fuzzel
        wlr-randr
        brightnessctl
      ]
      ++ [
        telegrams.packages.${pkgs.stdenv.hostPlatform.system}.ayugram-desktop
      ]
    );
}
