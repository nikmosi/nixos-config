{
  config,
  lib,
  ...
}:

lib.mkIf (config.nik.hardware.gpu == "nvidia") {
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidiaSettings = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
