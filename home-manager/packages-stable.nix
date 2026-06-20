{
  pkgs,
  telegrams,
  ...
}:
{
  home.packages =
    with pkgs;
    [
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
      vial
      chatterino2
      zotero
      thunderbird
      weave-gitops

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
    ]
    ++ [
      telegrams.packages.${pkgs.stdenv.hostPlatform.system}.ayugram-desktop
    ];
}
