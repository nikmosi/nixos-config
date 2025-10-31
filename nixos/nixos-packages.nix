{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # 🧠 Development Tools
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

    # 🧰 Build & Printing Stack
    hplip
    gutenprint
    cups
    librsvg
    gdk-pixbuf

    # 🔊 Audio / Sound
    pulseaudioFull
    qjackctl
    helvum

    # 🌐 Networking / VPN
    wireguard-tools
    sshfs

    # 🪟 GUI Utilities
    xclip
    xsel
    libnotify

    # 🐚 Shells
    fish
    nushell

    # ✍️ Editor
    neovim

    # ⚙️ CLI Utilities
    wget
    fd
    ripgrep
    bat
    git
    pciutils
    p7zip

    # 🔧 Utils for Tmux
    bc
    jq
  ];
}
