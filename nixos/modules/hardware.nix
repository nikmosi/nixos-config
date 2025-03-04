{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    package = pkgs.linuxPackages.nvidiaPackages.stable;
    nvidiaSettings = true;
    powerManagement.finegrained = false;
    powerManagement.enable = false;
    forceFullCompositionPipeline = true;
  };
}
