{ inputs, unstable, ... }:
{
  imports = [ inputs.home-manager.nixosModules.default ];

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit inputs unstable;
      telegrams = inputs.ayugram-desktop;
    };
    users.nik = import ../../home-manager/home.nix;
  };
}
