{ pkgs, ... }:
{
  users.defaultUserShell = pkgs.nushell;
  users.users.nik = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "input"
      "networkmanager"
      "docker"
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
