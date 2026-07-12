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
}
