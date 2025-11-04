{ pkgs, inputs, ... }:
{
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 5;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    wireguard.enable = true;
    networkmanager.enable = true;
    enableIPv6 = false;
    extraHosts = ''
      192.168.3.3 home
    '';
    nameservers = [
      "192.168.3.3"
      "1.1.1.1"
      "9.9.9.9"
    ];
  };

  time.timeZone = "Asia/Novosibirsk";

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://cache.nixos.org/" ];
    };
    optimise = {
      automatic = true;
      dates = [ "03:45" ];
    };
  };

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  i18n.defaultLocale = "en_US.UTF-8";

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    rootless = {
      enable = false;
      setSocketVariable = true;
    };
    extraOptions = ''
      --dns=8.8.8.8 --dns=1.1.1.1
    '';
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      gcc
      libgcc
      wineWowPackages.full
      wineWow64Packages.full
      glibc
      libGL
      freetype
      gnutls
      krb5
      samba
      xorg.libX11
      libcap
      cups
      gettext
      dbus
      cairo
      unixODBC
      samba4
      ncurses
      libva
      libpcap
      libv4l
      sane-backends
      libgphoto2
      libkrb5
      fontconfig
      alsa-lib
      xorg.libXinerama
      udev
      vulkan-loader
      SDL2
      libusb1
      gst_all_1.gstreamer
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-good
      gst_all_1.gst-plugins-ugly
      gst_all_1.gst-libav
      gst_all_1.gst-plugins-bad
      gtk3
      glib
      opencl-headers
      ocl-icd
      openssl
      gnutls
      libGLU
      libGL
      mesa
      libdrm
      xorg.libX11
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXext
      xorg.libXfixes
      xorg.libXi
      xorg.libXrandr
      xorg.libXrender
      xorg.libXxf86vm
    ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8888 22 25566 ];
    allowedUDPPorts = [ 8888 25566 ];
  };

  system.stateVersion = "25.05";
}
