{ lib, pkgs, ... }:
{
  networking.hostName = "desktop";
  networking.interfaces.eno1.ipv6.addresses = [ ];

  hardware.nvidia-container-toolkit.enable = true;

  services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  environment.systemPackages = lib.mkAfter (with pkgs; [
    mesa
  ]);
}
