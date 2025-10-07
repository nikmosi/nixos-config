{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    hplip
    gutenprint
    cups
    librsvg
    gdk-pixbuf
    gcc
    docker-buildx
    gnumake
    check
    pkg-config
    lcov
    clang-tools
    pulseaudioFull
    python312
    home-manager
    xclip
    xsel
    qjackctl
    helvum
    wireguard-tools
    # Editor
    neovim

    # Shell
    fish
    nushell

    # Utils
    sshfs
    libnotify
    pciutils
    wget
    fd
    ripgrep
    bat
    git
    clang
    p7zip

    # utils for tmux
    bc
    jq
  ];
}
