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
    ./redsocks.nix

    ./services/dnscrypt.nix
    ./services/libinput.nix
    ./services/logind.nix
    ./services/openssh.nix
    ./services/picom.nix
    ./services/v2raya.nix
  ];
}
