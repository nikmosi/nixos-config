{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  hardware.nvidia = {
    open = false;
    package = pkgs.linuxPackages.nvidiaPackages.stable;
  };
}
