{ config, lib, ... }:
{
  config = lib.mkIf config.local.cli.bash.enable {
    programs = {
      bash = {
        enable = true; # programs.bash.enable
        enableCompletion = true; # programs.bash.enableCompletion
        enableVteIntegration = true; # programs.bash.enableVteIntegration

        # History
        historySize = 5000; # programs.bash.historySize (in memory)
        historyFileSize = 10000; # programs.bash.historyFileSize (on disk)
        historyControl = [
          "ignoreboth"
          "erasedups"
        ]; # programs.bash.historyControl
        historyFile = "${config.home.homeDirectory}/.bash_history"; # programs.bash.historyFile
        historyIgnore = [
          "ls"
          "pwd"
          "exit"
        ]; # programs.bash.historyIgnore

        # Session vars and shell options
        sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
          LANG = "en_US.UTF-8";
          HISTTIMEFORMAT = "%F %T ";
        }; # programs.bash.sessionVariables

        shellOptions = [
          "histappend"
          "checkwinsize"
        ]; # programs.bash.shellOptions

        # Aliases
        shellAliases = {
          ll = "ls -al --group-directories-first";
          la = "ls -A";
          l = "ls -CF";
        }; # programs.bash.shellAliases

        # Extra commands to put into ~/.bashrc
        bashrcExtra = ""; # programs.bash.bashrcExtra

        # Extra commands to run when initializing an interactive shell
        initExtra = ''
          shopt -s globstar nullglob
        ''; # programs.bash.initExtra

        # Extra commands for login shells (profile)
        profileExtra = ''
          # keep PATH additions or envs here if needed
          export PATH="$HOME/.local/bin:$PATH"
        ''; # programs.bash.profileExtra

        # Extra commands run on logout
        logoutExtra = ''
          # no-op by default
        ''; # programs.bash.logoutExtra

      };
    };

    # Deploy ~/.inputrc (readline config)
    home.file.".inputrc".text = ''
      set editing-mode vi
      set show-all-if-ambiguous on
      set completion-ignore-case on
      "\t": menu-complete
      set colored-stats on
    '';
  };
}
