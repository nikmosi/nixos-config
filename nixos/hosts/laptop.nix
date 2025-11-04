{ lib, pkgs, ... }:
{
  networking.hostName = "laptop";

  powerManagement.powertop.enable = true;
  services.tlp.enable = true;

  environment.systemPackages = lib.mkAfter (with pkgs; [
    tlp
    powertop
  ]);

  hardware.opengl = {
    enable = lib.mkDefault true;
    driSupport = lib.mkDefault true;
    driSupport32Bit = lib.mkDefault true;
  };
}
