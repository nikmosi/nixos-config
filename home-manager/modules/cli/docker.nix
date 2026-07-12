{
  pkgs,
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.local.cli.docker.enable {
    home.file.".docker/cli-plugins/docker-buildx".source = "${pkgs.docker-buildx}/bin/docker-buildx";
  };
}
