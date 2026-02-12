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
  };

}
