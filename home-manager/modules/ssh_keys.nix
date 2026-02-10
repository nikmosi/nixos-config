{
  config,
  pkgs,
  lib,
  ...
}:

let
  sshDir = "${config.home.homeDirectory}/.ssh";
in
{
  home.activation.ensureSshDir = lib.hm.dag.entryBefore [ "writeBoundary" ] ''
    $DRY_RUN_CMD ${pkgs.coreutils}/bin/mkdir -p ${lib.escapeShellArg sshDir}
    $DRY_RUN_CMD ${pkgs.coreutils}/bin/chmod 700 ${lib.escapeShellArg sshDir}
  '';

  sops = {
    defaultSopsFile = ../../secrets/ssh.yaml;
    gnupg.home = "${config.home.homeDirectory}/.gnupg";

    secrets."ssh/common" = {
      path = "${sshDir}/common";
      mode = "0400";
    };

    secrets."ssh/common_pub" = {
      path = "${sshDir}/common.pub";
      mode = "0644";
    };

    secrets."ssh/id_ecdsa" = {
      path = "${sshDir}/id_ecdsa";
      mode = "0400";
    };

    secrets."ssh/id_ecdsa_pub" = {
      path = "${sshDir}/id_ecdsa.pub";
      mode = "0644";
    };
  };

}
