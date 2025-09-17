{
  imports = [
    ./audio.nix
    ./boot.nix
    ./dconf.nix
    ./env.nix
    ./fail2ban.nix
    ./hardware.nix
    ./home-manager.nix
    ./mime.nix
    ./programs.nix
    ./steam.nix
    ./udev.nix
    ./users.nix
    ./xserver.nix
    ./zram.nix
    ./pulse.nix

    ./services/libinput.nix
    ./services/logind.nix
    ./services/netdata.nix
    ./services/openssh.nix
    ./services/picom.nix
  ];
}
