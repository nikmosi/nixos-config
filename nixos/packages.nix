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
      python314
      home-manager

      # 🧰 Build & Printing Stack
      hplip
      gutenprint
      cups
      librsvg
      gdk-pixbuf

      # 🌐 Networking / VPN
      mtr
      wireguard-tools
      nftables
      iptables
      sshfs

      # 🪟 GUI Utilities
      libnotify
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
    ]);
}
