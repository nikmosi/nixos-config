_: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {

      "*" = {
        AddKeysToAgent = "yes";
        Compression = true;
        SetEnv = {
          TERM = "xterm-256color";
        };
        ServerAliveInterval = 60;
        ServerAliveCountMax = 3;

        ForwardAgent = true;
        ForwardX11 = false;

        IdentityFile = [ "~/.ssh/common" ];

        TCPKeepAlive = true;
        StrictHostKeyChecking = "accept-new";
      };

      "note-nixos" = {
        HostName = "192.168.3.10";
        Port = 63544;
      };

      "note-dns" = {
        User = "www";
        HostName = "192.168.3.3";
        Port = 22003;
      };

      "router" = {
        User = "root";
        HostName = "192.168.1.1";
        Port = 22;
      };

      "vpn-timeweb" = {
        HostName = "ollama.nikflora.ru";
        Port = 22;
      };

    };

    extraConfig = ''
      Host vpn-*
      User root
    '';

  };
}
