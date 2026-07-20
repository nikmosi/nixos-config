{ pkgs, config, lib, ... }:
let
  uplinkInterface = config.nik.networking.uplinkInterface;

  singBoxConfig = pkgs.writeText "sing-box-config.json" (builtins.toJSON {
    log = {
      level = "info";
      timestamp = true;
    };
    dns = {
      servers = [
        {
          type = "hosts";
          tag = "local-hosts";
          path = "/etc/hosts";
          predefined = {
            localhost = [ "127.0.0.1" "::1" ];
          };
        }
        {
          type = "udp";
          tag = "local-dns";
          server = "111.88.96.50";
          server_port = 53;
        }
        {
          type = "udp";
          tag = "doh";
          server = "1.1.1.1";
          server_port = 53;
        }
        {
          type = "udp";
          tag = "backup-dns";
          server = "94.140.14.14";
          server_port = 53;
        }
      ];
      rules = [
        {
          rule_set = [
            "geosite-ru-inside"
            "geosite-category-ru"
          ];
          server = "local-dns";
        }
        {
          domain_suffix = [ ".ru" ".su" ".рф" ];
          server = "local-dns";
        }
      ];
      final = "doh";
      strategy = "prefer_ipv4";
      cache_capacity = 4096;
    };
    inbounds = [
      {
        type = "tun";
        tag = "tun-in";
        interface_name = "singbox0";
        mtu = 1500;
        address = [ "172.31.255.1/30" ];
        auto_route = true;
        auto_redirect = false;
        strict_route = false;
        route_exclude_address = [
          "72.56.97.194/32"
          "31.76.77.41/32"
          "195.47.238.10/32"
          "212.233.79.153/32"
          "111.88.96.50/32"
          "94.140.14.14/32"
          "172.16.0.0/12"
          "192.168.0.0/16"
          "10.0.0.0/8"
        ];
        stack = "system";
      }
    ];
    outbounds = [
      {
        type = "socks";
        tag = "xray-out";
        server = "127.0.0.1";
        server_port = 26666;
        version = "5";
        username = "123";
        password = "123";
      }
      {
        type = "direct";
        tag = "direct";
      }
      {
        type = "block";
        tag = "block";
      }
    ];
    route = {
      rules = [
        {
          inbound = "tun-in";
          action = "sniff";
          timeout = "1s";
        }
        {
          port = 53;
          action = "hijack-dns";
        }
        {
          rule_set = [
            "geosite-ru-blocked"
            "geoip-ru-blocked"
            "refilter-domains"
            "refilter-ipsum"
            "geosite-google"
          ];
          outbound = "xray-out";
        }
        {
          rule_set = [
            "geosite-ru-inside"
            "geosite-category-ru"
            "geoip-ru"
          ];
          outbound = "direct";
        }
        {
          process_name = [
            "nginx"
            "caddy"
            "sshd"
            "v2rayN"
            "dnscrypt-proxy"
            ".qbittorrent-wr"
            "xray"
          ];
          outbound = "direct";
        }
        {
          ip_cidr = [
            "198.18.0.0/15"
            "fc00::/18"
          ];
          outbound = "xray-out";
        }
        {
          ip_is_private = true;
          outbound = "direct";
        }
      ];
      rule_set = [
        {
          type = "remote";
          tag = "refilter-domains";
          format = "binary";
          url = "https://github.com/1andrevich/Re-filter-lists/releases/latest/download/ruleset-domain-refilter_domains.srs";
          download_detour = "direct";
        }
        {
          type = "remote";
          tag = "refilter-ipsum";
          format = "binary";
          url = "https://github.com/1andrevich/Re-filter-lists/releases/latest/download/ruleset-ip-refilter_ipsum.srs";
          download_detour = "direct";
        }
        {
          type = "remote";
          tag = "geosite-ru-inside";
          format = "binary";
          url = "https://raw.githubusercontent.com/runetfreedom/russia-v2ray-rules-dat/release/sing-box/rule-set-geosite/geosite-ru-available-only-inside.srs";
          download_detour = "direct";
        }
        {
          type = "remote";
          tag = "geosite-category-ru";
          format = "binary";
          url = "https://raw.githubusercontent.com/runetfreedom/russia-v2ray-rules-dat/release/sing-box/rule-set-geosite/geosite-category-ru.srs";
          download_detour = "direct";
        }
        {
          type = "remote";
          tag = "geosite-google";
          format = "binary";
          url = "https://raw.githubusercontent.com/runetfreedom/russia-v2ray-rules-dat/release/sing-box/rule-set-geosite/geosite-google.srs";
          download_detour = "direct";
        }
        {
          type = "remote";
          tag = "geosite-ru-blocked";
          format = "binary";
          url = "https://raw.githubusercontent.com/runetfreedom/russia-v2ray-rules-dat/release/sing-box/rule-set-geosite/geosite-ru-blocked.srs";
          download_detour = "direct";
        }
        {
          type = "remote";
          tag = "geoip-ru";
          format = "binary";
          url = "https://raw.githubusercontent.com/runetfreedom/russia-v2ray-rules-dat/release/sing-box/rule-set-geoip/geoip-ru.srs";
          download_detour = "direct";
        }
        {
          type = "remote";
          tag = "geoip-ru-blocked";
          format = "binary";
          url = "https://raw.githubusercontent.com/runetfreedom/russia-v2ray-rules-dat/release/sing-box/rule-set-geoip/geoip-ru-blocked.srs";
          download_detour = "direct";
        }
      ];
      final = "xray-out";
      auto_detect_interface = true;
      default_domain_resolver = "doh";
    };
    experimental = {
      cache_file = {
        enabled = true;
      };
    };
  });
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
      "xray.service"
    ];
    wants = [
      "network-online.target"
    ];
    requires = [
      "xray.service"
    ];
    path = with pkgs; [
      bash
      coreutils
      nftables
    ];

    serviceConfig = {
      ExecStart = "${pkgs.unstable.sing-box}/bin/sing-box run -c ${singBoxConfig}";
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
