{ pkgs, config, ... }:
let
  xrayAssets = ../../assets/xray;
in
{
  sops = {
    secrets = {
      "xray/inbound/user" = { };
      "xray/inbound/pass" = { };
      "xray/ollama/address" = { };
      "xray/ollama/uuid" = { };
      "xray/ollama/encryption" = { };
      "xray/finka/address" = { };
      "xray/finka/uuid" = { };
      "xray/finka/encryption" = { };
    };

    templates."xray-config.json" = {
      content = builtins.toJSON {
        log = {
          loglevel = "info";
        };

        assetPath = "${xrayAssets}";

        dns = {
          servers = [
            "1.1.1.1"
            "localhost"
          ];
        };

        routing = {
          domainStrategy = "AsIs";
          rules = [ ];
          final = "vless-ollama";
        };

        inbounds = [
          {
            tag = "mixed-in";
            port = 26666;
            listen = "127.0.0.1";
            protocol = "mixed";
            settings = {
              auth = "password";
              accounts = [
                {
                  user = config.sops.placeholder."xray/inbound/user";
                  pass = config.sops.placeholder."xray/inbound/pass";
                }
              ];
              udp = true;
            };
            sniffing = {
              enabled = true;
              destOverride = [
                "http"
                "tls"
              ];
            };
          }
        ];

        outbounds = [
          {
            tag = "vless-ollama";
            protocol = "vless";
            settings = {
              vnext = [
                {
                  address = config.sops.placeholder."xray/ollama/address";
                  port = 443;
                  users = [
                    {
                      id = config.sops.placeholder."xray/ollama/uuid";
                      encryption = config.sops.placeholder."xray/ollama/encryption";
                    }
                  ];
                }
              ];
            };
            streamSettings = {
              network = "xhttp";
              security = "tls";
              tlsSettings = {
                serverName = "ollama.nikflora.ru";
                fingerprint = "firefox";
                alpn = [
                  "h2"
                  "http/1.1"
                ];
              };
              xhttpSettings = {
                mode = "auto";
                path = "/";
                host = "";
                extra = {
                  mode = "auto";
                  xPaddingBytes = "100-1000";
                  xPaddingObfsMode = true;
                };
              };
            };
          }

          {
            tag = "vless-finka";
            protocol = "vless";
            settings = {
              vnext = [
                {
                  address = config.sops.placeholder."xray/finka/address";
                  port = 443;
                  users = [
                    {
                      id = config.sops.placeholder."xray/finka/uuid";
                      encryption = config.sops.placeholder."xray/finka/encryption";
                    }
                  ];
                }
              ];
            };
            streamSettings = {
              network = "xhttp";
              security = "tls";
              tlsSettings = {
                serverName = "finka.fluxus.org";
                fingerprint = "firefox";
                alpn = [
                  "h2"
                  "http/1.1"
                ];
              };
              xhttpSettings = {
                mode = "auto";
                path = "/";
                host = "";
                extra = {
                  mode = "auto";
                  xPaddingBytes = "100-1000";
                };
              };
            };
          }

          {
            tag = "direct";
            protocol = "freedom";
            settings = { };
          }

          {
            tag = "block";
            protocol = "blackhole";
            settings = { };
          }
        ];
      };
    };
  };

  systemd.services.xray = {
    description = "xray proxy";
    wantedBy = [ "multi-user.target" ];
    after = [
      "network-online.target"
    ];
    wants = [
      "network-online.target"
    ];
    path = with pkgs; [
      bash
      coreutils
      nftables
    ];

    serviceConfig = {
      ExecStart = "${pkgs.xray}/bin/xray run -c ${config.sops.templates."xray-config.json".path}";
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
