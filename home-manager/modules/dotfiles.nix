{ config, lib, ... }:
{
  options.dotfiles = {
    path = lib.mkOption {
      type = lib.types.path;
      apply = toString;
      default = "${config.home.homeDirectory}/.flake";
      description = "Location of the dotfiles working copy";
    };

    mutable = lib.mkEnableOption "mutable dotfiles" // {
      default = true;
    };
  };
}
