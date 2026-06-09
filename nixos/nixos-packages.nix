{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # 🧠 Development Tools
    pre-commit
    gcc
    gnumake
    check
    pkg-config
    lcov
    clang
    clang-tools
    docker-buildx
    python312
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
    sing-box
    sing-geoip
    sing-geosite

    # 🪟 GUI Utilities
    xclip
    xsel
    libnotify

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
  ];
}
