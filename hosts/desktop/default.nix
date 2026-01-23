{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../nixos/configuration.nix # The shared core config
    ../../modules/gpu/nvidia.nix
    ../../modules/display/desktop-dual.nix
  ];
}
