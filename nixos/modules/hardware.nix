{ config, ... }:
{
  nixpkgs.config.allowUnfree = true;
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidiaSettings = true;
    powerManagement.finegrained = false;
    powerManagement.enable = false;
    forceFullCompositionPipeline = true;
  };
}
