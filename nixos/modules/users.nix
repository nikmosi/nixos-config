{ pkgs, userSettings, ... }:
{
  users.defaultUserShell = pkgs.fish;
  users.users.${userSettings.username} = {
    isNormalUser = true;
    extraGroups = [
      "wine-share"
      "wheel"
      "gamemode"
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

  users.users.epic = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "networkmanager"
      "docker"
    ];
    shell = pkgs.fish;
  };
  users.groups.wine-share = { };
}
