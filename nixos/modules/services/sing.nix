{ pkgs, ... }:
{
  systemd.services.sing-box = {
    description = "sing-box";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.sing-box}/bin/sing-box run -c /etc/sing-box/config.json";
      Restart = "on-failure";
      RestartSec = "5s";
      LimitNOFILE = 1048576;
    };
  };
}
