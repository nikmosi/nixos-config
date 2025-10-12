{ pkgs, ... }:
{
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelPackages = pkgs.linuxPackages;
}
