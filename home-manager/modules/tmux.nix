{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    secureSocket = false;

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      sensible
      tmux-fzf
      open
      tokyo-night-tmux
      yank
    ];
    historyLimit = 30000;
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;
    prefix = "C-j";
    sensibleOnTop = true;
    terminal = "tmux-256color";
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      set-option -sa terminal-overrides ",*:Smulx=\E[4::%p1%dm"
      set-option -sa terminal-overrides ",*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m"
      set-option -g allow-passthrough on

      set -g pane-base-index 1
      set -g renumber-windows on
      set -g pane-border-lines double
      set  -s escape-time       0
      bind -n M-Enter new-window

      # set  -g default-terminal "tmux-256color"

      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      bind s choose-tree -sZ -O name

      # Key remapping
      unbind %
      bind | split-window -h -c "#{pane_current_path}"

      unbind '"'
      bind - split-window -v -c "#{pane_current_path}"

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
