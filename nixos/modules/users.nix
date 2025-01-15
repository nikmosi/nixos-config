{ pkgs, ... }:
{
  users.defaultUserShell = pkgs.fish;
  users.users.nik = {
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
