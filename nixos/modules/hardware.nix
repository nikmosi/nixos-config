{pkgs, ...}:
{
 hardware.nvidia = {
  enable = true;
  open = true;
  package = pkgs.linuxPackages.nvidiaPackages.stable;
 };
}
