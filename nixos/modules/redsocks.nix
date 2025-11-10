{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.redsocks ];
  networking.nftables.enable = true;

  environment.etc."redsocks.conf".text = ''
    base { log_debug = off; log_info = on; log = "syslog:daemon"; daemon = on; user = "nobody"; group = "nogroup"; redirector = iptables; }
    redsocks {
      local_ip = 127.0.0.1; local_port = 12345;
      ip = 127.0.0.1; port = 12334; type = socks5;  # use http-connect if needed
      login = ""; password = "";
    }
  '';

  systemd.services.redsocks = {
    description = "redsocks transparent redirector";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.redsocks}/bin/redsocks -c /etc/redsocks.conf";
      DynamicUser = true;
      Restart = "always";
    };
  };

  networking.nftables.tables.nat = {
    family = "ip";
    content = ''
      table ip nat {
        chain output {
          type nat hook output priority dstnat; policy accept;
          ip daddr 127.0.0.0/8 return
          tcp dport {12345, 12334} return
          tcp redirect to :12345
        }
      }
    '';
  };

}
