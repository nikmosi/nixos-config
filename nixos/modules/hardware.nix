{ config, ... }:
{
  nixpkgs.config.allowUnfree = true;
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidiaSettings = true;
    powerManagement.finegrained = false;
    powerManagement.enable = false;
    forceFullCompositionPipeline = true;
  };
}
