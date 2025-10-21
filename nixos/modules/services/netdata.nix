{ pkgs, ... }:
{

  services.netdata = {
    enable = false;
    config = {
      global = {
        "bind to" = "*";
        "memory mode" = "ram";
        "debug log" = "none";
        "access log" = "none";
        "error log" = "syslog";
      };
    };

    package = pkgs.netdata.override {
      withCloudUi = true;
    };

  };

  services.netdata.configDir."stream.conf" =
    let
      mkChildNode = apiKey: allowFrom: ''
        [${apiKey}]
          enabled = yes
          default history = 500
          default memory mode = dbengine # a good default
          health enabled by default = auto
          allow from = ${allowFrom}
      '';
    in
    pkgs.writeText "stream.conf" ''
      [stream]
        # This won't stream by itself, except if the receiver is a sender too, which is possible in netdata model.
        enabled = no
        enable compression = yes

      # An allowed sender node
      ${mkChildNode "63d9241a-8ab9-4268-8c25-35ce314ffd3b" "*"}
    '';
}
