{ userSettings, config, ... }:
{
  networking = {
    hostName = userSettings.hostname;
    domain = "home.lan";
    networkmanager = {
      enable = true;
      dns = "none";
    };
    enableIPv6 = false;
    extraHosts = config.nik.networking.extraHosts;
    # interfaces.eno1.ipv6.addresses = [ ];

    nameservers = [
      "9.9.9.9"
      # "127.0.0.1"
      # "::1"
      # "192.168.3.10"
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
