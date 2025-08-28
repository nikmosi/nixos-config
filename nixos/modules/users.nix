{ pkgs, ... }:
{
  users.defaultUserShell = pkgs.fish;
  users.users.nik = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "input"
      "networkmanager"
      "docker"
      "vboxusers"
    ];
    shell = pkgs.nushell;
  };
  users.users.nvimfromscratch = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "networkmanager"
      "docker"
    ];
    shell = pkgs.fish;
  };
}
