{ pkgs, ... }:
{
  programs.atuin = {
    enable = true;
    package = pkgs.unstable.atuin;
  };
}
