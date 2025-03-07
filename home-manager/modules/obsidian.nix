{ pkgs, ... }:
let
  gitSyncObsidian = pkgs.writeScriptBin "git-sync-obsidian" ''
    #!${pkgs.bash}/bin/bash

    VAULT_DIR="$HOME/Documents/base"
    cd $VAULT_DIR || exit 1
    git add .
    git commit --no-signoff -m "chore" || exit 0
  '';
in
{
  home.packages = [ gitSyncObsidian ];

  systemd.user.services.git-sync-obsidian = {
    Unit = {
      Description = "Sync Obsidian Vault with GitHub";
      Wants = "git-sync-obsidian.timer";
    };
    Service = {
      ExecStart = "${gitSyncObsidian}/bin/git-sync-obsidian";
      Type = "simple";
    };
  };

  systemd.user.timers.git-sync-obsidian = {
    Unit.Description = "Run Git Sync for Obsidian Vault";
    Timer.OnCalendar = "*:0/1";
    Install.WantedBy = [ "timers.target" ];
  };
}
