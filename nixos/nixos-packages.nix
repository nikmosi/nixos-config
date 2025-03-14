{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pulseaudioFull
    python312
    home-manager
    xclip
    xsel
    qjackctl
    helvum
    # Editor
    neovim

    # Shell
    fish
    alacritty

    # Utils
    nixfmt-rfc-style
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
