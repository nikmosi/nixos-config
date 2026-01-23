{ pkgs, userSettings, ... }:
{
  users.defaultUserShell = pkgs.fish;
  users.users.${userSettings.username} = {
    isNormalUser = true;
    extraGroups = [
      "wine-share"
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
  # --- add this ---
  users.users.redsocks = {
    isSystemUser = true;
    description = "Service user for redsocks proxy daemon";
    group = "redsocks";
    extraGroups = [ "wine-share" ];
    home = "/var/lib/redsocks";
    createHome = true;
    shell = pkgs.shadow;
  };

  users.groups.redsocks = { }; # corresponding group
  users.groups.wine-share = { };
}
