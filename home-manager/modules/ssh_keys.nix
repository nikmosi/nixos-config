{
  config,
  ...
}:

let
  sopsSecretsDir = "${config.xdg.configHome}/sops-nix/secrets";
in
{
  home.file.".ssh".directory = true;
  home.file.".ssh".mode = "0700";

  sops = {
    defaultSopsFile = ./secrets/ssh.yaml;

    secrets."ssh/common" = {
      mode = "0400";
    };
    secrets."ssh/id_ecdsa" = {
      mode = "0400";
    };

    secrets."ssh/common_pub" = {
      mode = "0644";
    };
    secrets."ssh/id_ecdsa_pub" = {
      mode = "0644";
    };
  };

  home.file.".ssh/common".source = "${sopsSecretsDir}/ssh/common";
  home.file.".ssh/common".target = ".ssh/common";
  home.file.".ssh/common".mode = "0400";

  home.file.".ssh/common.pub".source = "${sopsSecretsDir}/ssh/common_pub";
  home.file.".ssh/common.pub".target = ".ssh/common.pub";
  home.file.".ssh/common.pub".mode = "0644";

  home.file.".ssh/id_ecdsa".source = "${sopsSecretsDir}/ssh/id_ecdsa";
  home.file.".ssh/id_ecdsa".target = ".ssh/id_ecdsa";
  home.file.".ssh/id_ecdsa".mode = "0400";

  home.file.".ssh/id_ecdsa.pub".source = "${sopsSecretsDir}/ssh/id_ecdsa_pub";
  home.file.".ssh/id_ecdsa.pub".target = ".ssh/id_ecdsa.pub";
  home.file.".ssh/id_ecdsa.pub".mode = "0644";

}
