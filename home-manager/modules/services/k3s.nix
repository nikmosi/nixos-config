{ pkgs, ... }:
{
  systemd.user.services.ssh-tunnel-k3s = {
    Unit = {
      Description = "SSH Local Port Forwarding to remote.host";
      After = [ "network-online.target" ];
    };
    Service = {
      ExecStart = ''
        ${pkgs.openssh}/bin/ssh -N -q \
          -o ServerAliveInterval=15 \
          -o ServerAliveCountMax=3 \
          -o ExitOnForwardFailure=yes \
          -L 6443:127.0.0.1:6443 \
          -p 63001 \
          nik@home.nikflora.ru
      '';
      Restart = "always";
      RestartSec = 5;
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
