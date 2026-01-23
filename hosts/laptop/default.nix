{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../nixos/configuration.nix # The shared core config
    ../../modules/gpu/amd.nix
  ];
}
