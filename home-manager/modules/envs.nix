{ config, ... }:

let
  configDir = config.xdg.configHome;
in
{
  sops = {
    gnupg.home = "${config.home.homeDirectory}/.gnupg";

    secrets = {
      "envs/awesome" = {
        path = "${configDir}/awesome/.env";
        mode = "0400";
      };

      "api_keys/timeweb/terraform_api_key" = {
        path = "/home/nik/git-repos/DO11/src/terraform/.envrc";
        mode = "0400";
      };

      "api_keys/github/nikmosi" = { };
    };

    templates."nix.conf" = {
      content = ''
        access-tokens = github.com=${config.sops.placeholder."api_keys/github/nikmosi"}
      '';
      path = "${configDir}/nix/nix.conf";
      mode = "0400";
    };
  };

}
