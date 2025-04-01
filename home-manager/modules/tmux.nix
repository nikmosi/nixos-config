{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    secureSocket = false;

    plugins = with pkgs.tmuxPlugins; [
      tokyo-night-tmux
      vim-tmux-navigator
      sensible
      tmux-fzf
      open
    ];
    historyLimit = 30000;
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;
    prefix = "C-j";
    sensibleOnTop = true;
    shell = "${pkgs.nushell}/bin/nu";
    terminal = "screen-256color";
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"

      set -g @tmux_power_time_format '%H:%M'
      set -g @tmux_power_theme '#8AB5FA' # dark slate blue

      bind s choose-tree -sZ -O name

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


      set-window-option -g mode-keys vi

      bind-key -T copy-mode-vi 'v' send -X begin-selection 
      bind-key -T copy-mode-vi 'y' send -X copy-selection
      bind-key x kill-pane
      set -g detach-on-destroy off
    '';
  };
}
