{ ... }:
{
  imports = [
    ./21-packages.nix
    ./packages-stable.nix
    ./packages-unstable.nix
  ];
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "electron-38.8.4" ];
  };
}
