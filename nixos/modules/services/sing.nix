{ pkgs, unstable, ... }:
let
  uplinkInterface = "eno1";
  hostIPv4 = "192.168.3.2";
in
{
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv4.conf.all.rp_filter" = 0;
    "net.ipv4.conf.${uplinkInterface}.rp_filter" = 0;
  };

  systemd.services.sing-box = {
    description = "sing-box";
    wantedBy = [ "multi-user.target" ];
    after = [
      "network-online.target"
      "docker.service"
    ];
    wants = [
      "network-online.target"
      "docker.service"
    ];
    path = with pkgs; [
      bash
      coreutils
      nftables
    ];

    # postStart = ''
    #   timeout 10s bash -c 'until nft list table inet sing-box >/dev/null 2>&1; do sleep 0.5; done'
    #
    #   nft insert rule inet sing-box output index 0 ip saddr ${hostIPv4} accept
    #   nft insert rule inet sing-box prerouting index 0 ip saddr ${hostIPv4} accept
    #
    #   nft insert rule inet sing-box prerouting index 0 iifname "br-*" accept
    #   nft insert rule inet sing-box prerouting index 0 iifname "docker0" accept
    #   nft insert rule inet sing-box output index 0 oifname "br-*" accept
    #   nft insert rule inet sing-box output index 0 oifname "docker0" accept
    # '';
    #
    # postStop = ''
    #   nft flush table inet sing-box >/dev/null 2>&1 || true
    # '';
    #
    serviceConfig = {
      ExecStart = "${unstable.sing-box}/bin/sing-box run -c /etc/sing-box/config.json";
      User = "root";
      Group = "root";
      CapabilityBoundingSet = [
        "CAP_NET_ADMIN"
        "CAP_NET_BIND_SERVICE"
        "CAP_SYS_PTRACE"
        "CAP_DAC_READ_SEARCH"
      ];
      AmbientCapabilities = [
        "CAP_NET_ADMIN"
        "CAP_NET_BIND_SERVICE"
        "CAP_SYS_PTRACE"
        "CAP_DAC_READ_SEARCH"
      ];
      Restart = "on-failure";
      RestartSec = "5s";
      LimitNOFILE = 1048576;
    };
  };
}
