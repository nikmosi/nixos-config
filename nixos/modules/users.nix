{ pkgs, userSettings, ... }:
{
  programs.xonsh.enable = true;
  programs.fish.enable = true;

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
    shell = pkgs.xonsh;
  };
}
