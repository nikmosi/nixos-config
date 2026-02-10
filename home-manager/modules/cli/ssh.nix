{ ... }:
{
  programs.ssh = {
    enable = true;

    extraConfig = ''
      Host *
        Compression yes
        SetEnv TERM=xterm-256color
        ServerAliveInterval 60
        ServerAliveCountMax 3
        TCPKeepAlive yes
        ForwardAgent yes
        ForwardX11 no
        IdentityFile ~/.ssh/common
        StrictHostKeyChecking accept-new

      Host vpn-*
        User root
    '';

    matchBlocks = {
      "vpn-aeza" = {
        hostname = "5.182.86.229";
        port = 22;
      };

      "vpn-timeweb" = {
        hostname = "ollama.nikflora.ru";
        port = 22;
      };
    };
  };
}
