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

      "api_keys/gh/oauth_token" = { };

      "opencode/context7_api_key" = {
        path = "${configDir}/opencode/secrets/context7_api_key";
        mode = "0400";
      };

      "opencode/tavily_api_key" = {
        path = "${configDir}/opencode/secrets/tavily_api_key";
        mode = "0400";
      };
    };

    templates."gh-hosts" = {
      content = ''
        github.com:
            users:
                nikmosi:
                    oauth_token: ${config.sops.placeholder."api_keys/gh/oauth_token"}
            git_protocol: ssh
            user: nikmosi
            oauth_token: ${config.sops.placeholder."api_keys/gh/oauth_token"}
      '';
      path = "${configDir}/gh/hosts.yml";
      mode = "0600";
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
