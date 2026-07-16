{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];
}
