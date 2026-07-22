{
  pkgs,
  config,
  lib,
  ...
}:

{
  environment.systemPackages =
    (with pkgs.unstable; [
      xray
    ])
    ++ (with pkgs; [
      # 🧠 Development Tools
      gnumake
      check
      pkg-config
      lcov
      python314
      home-manager
      jqp

      # 🧰 Build & Printing Stack
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
    ])
    ++ lib.optionals config.nik.hardware.printer (
      with pkgs;
      [
        hplip
        gutenprint
        cups
      ]
    );
}
