{ pkgs, ... }:
{
  systemd.user.services.tmux-server = {
    Unit = {
      Description = "Tmux Server";
      After = [ "network.target" ];
    };
    Service = {
      Type = ''forking'';
      # ExecStart = ''/home/nik/.nix-profile/bin/tmux new-session -d -s auto'';
      ExecStart = ''${pkgs.tmux}/bin/tmux new-session -d -s auto'';
      TimeoutStartSec = "10s";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  programs.tmux = {
    enable = true;
    secureSocket = false;

    plugins = with pkgs.tmuxPlugins; [
      nord
      tmux-fzf
      sessionist
      open
      sensible
      vim-tmux-navigator
      tokyo-night-tmux
      resurrect
      continuum
    ];
    historyLimit = 30000;
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"

      set -g @resurrect-capture-pane-contents 'on'
      set -g @continuum-restore 'on'
      set -g @tmux_power_time_format '%H:%M'
      set -g @tmux_power_theme '#8AB5FA' # dark slate blue

      set -g default-terminal "screen-256color"
      set -g prefix C-j

      bind s choose-tree -sZ -O name

      set -g base-index 1
      setw -g pane-base-index 1

      # Key remapping
      unbind %
      bind | split-window -h 

      unbind '"'
      bind - split-window -v

      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5

      bind -r m resize-pane -Z

      set -g mouse on

      set-window-option -g mode-keys vi

      bind-key -T copy-mode-vi 'v' send -X begin-selection 
      bind-key -T copy-mode-vi 'y' send -X copy-selection
    '';
  };
}
