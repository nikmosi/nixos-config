{ userSettings, ... }:
{
  networking = {
    hostName = userSettings.hostname;
    domain = "home.lan";
    wireguard.enable = false;
    networkmanager = {
      enable = true;
      dns = "none";
    };
    dhcpcd.extraConfig = "nohook resolv.conf";
    enableIPv6 = false;
    extraHosts = ''
      192.168.3.3 home
      127.0.0.1 rustek.localhost
      127.0.0.1 auth.rustek.localhost
    '';
    # interfaces.eno1.ipv6.addresses = [ ];

    nameservers = [
      "9.9.9.9"
      # "127.0.0.1"
      # "::1"
      "192.168.3.10"
    ];

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    firewall = {
      # trustedInterfaces = [ "eno06" ];
      # allowedTCPPorts = [
      #   22 # ssh
      #   80 # http
      #   443 # https
      #   22000
      # ];
      # allowedUDPPorts = [
      #   22
      #   22000
      # ];
      enable = false;
    };
  };
}
