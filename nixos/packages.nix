{ pkgs, ... }:
{

  environment.systemPackages =
    (with pkgs.unstable; [
      sing-box
      sing-geoip
      sing-geosite
    ])
    ++ (with pkgs; [
      # 🧠 Development Tools
      gnumake
      check
      pkg-config
      lcov
      docker-buildx
      python314
      home-manager
      sshuttle
      # extra-utils

      # 🧰 Build & Printing Stack
      hplip
      gutenprint
      cups
      librsvg
      gdk-pixbuf

      # 🔊 Audio / Sound
      pulseaudioFull
      qjackctl

      # 🌐 Networking / VPN
      mtr
      wireguard-tools
      nftables
      iptables
      sshfs

      # 🪟 GUI Utilities
      xclip
      xsel
      libnotify
      wl-clipboard
      grim
      slurp
      swaybg

      # 🐚 Shells
      fish
      nushell

      # ⚙️ CLI Utilities
      wget
      fd
      pciutils
      p7zip
      sops

      # 🔧 Utils for Tmux
      bc
      jq
      xray
    ]);
}
