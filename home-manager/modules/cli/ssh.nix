{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks."*" = {
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

    extraConfig = ''
      Host vpn-*
        User root
    '';

    matchBlocks."vpn-aeza" = {
      hostname = "5.182.86.229";
      port = 22;
    };

    matchBlocks."vpn-timeweb" = {
      hostname = "ollama.nikflora.ru";
      port = 22;
    };
  };
}
