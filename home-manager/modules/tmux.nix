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
    terminal = "xterm-kitty";
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      set-option -g allow-passthrough on

      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

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

      bind-key "t" display-popup -yC -xR -E -b rounded -s 'bg=#1a1b26,fg=#c0caf5' -S 'fg=#7aa2f7,bg=#1a1b26' 'sesh connect (sesh list --icons | fzf
        --no-sort --ansi --border-label " sesh " --prompt "⚡  " 
        --header "  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find" 
        --bind "tab:down,btab:up" 
        --bind "ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)" 
        --bind "ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)" 
        --bind "ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)" 
        --bind "ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)" 
        --bind "ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)" 
        --bind "ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)" 
        --preview-window "right:55%" \
        --preview "sesh preview {}"
      )' 

      set-window-option -g mode-keys vi

      bind-key -T copy-mode-vi 'v' send -X begin-selection 
      bind-key -T copy-mode-vi 'y' send -X copy-selection

      bind-key x kill-pane
      set -g detach-on-destroy off
    '';
  };
}
