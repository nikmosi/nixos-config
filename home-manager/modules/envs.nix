{
  config,
  ...
}:

let
  configDir = config.xdg.configHome;
in
{
  sops = {
    gnupg.home = "${config.home.homeDirectory}/.gnupg";

    secrets."envs/awesome" = {
      path = "${configDir}/awesome/.env";
      mode = "0400";
    };

    secrets."api_keys/timeweb/terraform_api_key" = {
      path = "/home/nik/git-repos/DO11/src/terraform/.envrc";
      mode = "0400";
    };
  };

}
