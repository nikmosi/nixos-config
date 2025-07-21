{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
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
