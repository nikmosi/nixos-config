{ ... }:
{
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.dragAndDrop = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "nik" ];

  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker = {
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
}
