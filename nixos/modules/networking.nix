{ userSettings, ... }:
{
  networking.hostName = userSettings.hostname;
  networking.domain = "home.lan";
  networking.wireguard.enable = false;
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";
  networking.dhcpcd.extraConfig = "nohook resolv.conf";
  networking.enableIPv6 = false;
  networking.extraHosts = ''
    192.168.3.3 home
    127.0.0.1 rustek.localhost
    127.0.0.1 auth.rustek.localhost
  '';
  # networking.interfaces.eno1.ipv6.addresses = [ ];

  networking.nameservers = [
    "9.9.9.9"
    # "127.0.0.1"
    # "::1"
    "192.168.3.10"
  ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.trustedInterfaces = [ "eno06" ];
  # networking.firewall.allowedTCPPorts = [
  #   22 # ssh
  #   80 # http
  #   443 # https
  #   22000
  # ];
  # networking.firewall.allowedUDPPorts = [
  #   22
  #   22000
  # ];
  # # Or disable the firewall altogether.
  networking.firewall.enable = false;
}
