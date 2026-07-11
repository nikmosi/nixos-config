{ userSettings, pkgs, ... }:
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
      extraOptions = ''
        --dns=8.8.8.8 --dns=1.1.1.1
      '';
    };
  };

  users.extraGroups.vboxusers.members = [ userSettings.username ];
  users.extraGroups.libvirtd.members = [ userSettings.username ];

  hardware.nvidia-container-toolkit.enable = true;
}
