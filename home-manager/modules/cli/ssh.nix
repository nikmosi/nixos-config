{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {

      "*" = {
        addKeysToAgent = "yes";
        compression = true;
        setEnv = {
          TERM = "xterm-256color";
        };
        serverAliveInterval = 60;
        serverAliveCountMax = 3;

        forwardAgent = true;
        forwardX11 = false;

        identityFile = [ "~/.ssh/common" ];

        extraOptions = {
          TCPKeepAlive = "yes";
          StrictHostKeyChecking = "accept-new";
        };
      };

      "note" = {
        hostname = "192.168.3.10";
        port = 63544;
      };

      "router" = {
        user = "root";
        hostname = "192.168.1.1";
        port = 22;
      };

      "vpn-timeweb" = {
        hostname = "ollama.nikflora.ru";
        port = 22;
      };

      "vpn-moscow" = {
        hostname = "rus.nikflora.ru";
        port = 22;
      };
    };

    extraConfig = ''
      Host vpn-*
        User root
    '';

  };
}
