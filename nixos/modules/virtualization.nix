{
  userSettings,
  pkgs,
  config,
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
    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
    };
    docker = {
      enable = true;
      storageDriver = "btrfs";
      rootless = {
        enable = false;
        setSocketVariable = true;
      };
      extraOptions = builtins.concatStringsSep " " (map (dns: "--dns=${dns}") config.nik.docker.dns);
    };
  };

  users.extraGroups.vboxusers.members = [ userSettings.username ];
  users.extraGroups.libvirtd.members = [ userSettings.username ];

  hardware.nvidia-container-toolkit.enable = true;
}
