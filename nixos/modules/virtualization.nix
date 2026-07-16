{
  userSettings,
  pkgs,
  config,
  lib,
  ...
}:
{
  programs.virt-manager.enable = true;

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
    };
    virtualbox = lib.mkIf config.nik.virtualization.virtualbox.enable {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
    };
    docker = {
      enable = true;
      storageDriver = config.nik.virtualization.docker.storageDriver;
      rootless = {
        enable = false;
        setSocketVariable = true;
      };
      extraOptions = builtins.concatStringsSep " " (map (dns: "--dns=${dns}") config.nik.docker.dns);
    };
  };

  users.extraGroups.vboxusers.members = lib.optional config.nik.virtualization.virtualbox.enable userSettings.username;
  users.extraGroups.libvirtd.members = [ userSettings.username ];

  hardware.nvidia-container-toolkit.enable = lib.mkIf (config.nik.hardware.gpu == "nvidia") true;
}
