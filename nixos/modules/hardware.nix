{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  hardware.nvidia = {
    open = true;
    package = pkgs.linuxPackages.nvidiaPackages.stable;
  };
}
