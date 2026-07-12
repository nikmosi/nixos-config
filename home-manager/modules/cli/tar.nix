{
  pkgs,
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.local.cli.tar.enable {
    home.packages = with pkgs; [
      xz
      zstd
    ];

    home.shellAliases = {
      untar = "tar -xvf";
      tarc = "tar -cJvf";
      tarls = "tar -tvf";
    };
  };
}
