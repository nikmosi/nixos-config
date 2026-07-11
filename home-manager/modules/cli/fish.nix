{ lib, ... }:
let
  fzfFishPlugin = builtins.fetchGit {
    url = "https://github.com/patrickf1/fzf.fish";
    ref = "main";
    rev = "c2f3a0b6c940735c5df8f6f2c2c7e6f5a1c2b3d4";
  };

  bassPlugin = builtins.fetchGit {
    url = "https://github.com/edc/bass";
    ref = "master";
    rev = "c782c5f5c0d4d2a3f3c1e2d3a4b5c6d7e8f9a0b1";
  };

  fishDir = ./fish;
in
{
  programs.fish = {
    enable = true;

    shellAliases = {
      v = "nvim";
      se = "sudoedit";
      swo = "nh os switch";
      upd = "nh os switch --update";
      hms = "nh home switch";
      abs = "readlink -f";
      cat = "bat";
      md = "mkdir -p";
      rd = "rmdir";
      py = "python";
      prename = "perl-rename";
      grep = "rg";
      sortnr = "sort -n -r";
      tt = "tail -f";
      to_clip = "wl-copy";
      tree = "eza --tree";
      d = "ripdrag -a -x";
      mv = "mv -i";
      cp = "cp -i";
      l = "eza -lhF";
      la = "eza -lAhF";
      lr = "eza -tRhF";
      lt = "eza -lthF";
      ll = "eza -l";
      ldot = "eza -ld .*";
      lS = "eza -1SshF";
      lart = "eza -1cartF";
      lrt = "eza -1crtF";
      lsr = "eza -lARhF";
      lsn = "eza -1";
      k = "kubecolor";
      kx = "kubectx";
      ks = "kubens";
      c = "codex";
    };

    shellAbbrs = {
      "-" = "z -";
      "..." = "../..";
      "...." = "../../..";
      "....." = "../../../..";
      "......" = "../../../../..";
      H = "| head";
      L = "| less";
      G = "| rg";
      LL = "2>&1 | less";
      M = "| most";
      NE = "2> /dev/null";
      NUL = "> /dev/null 2>&1";
      P = "2>&1| pygmentize -l pytb";
      T = "| tail";
      CA = "2>&1 | cat -A";
      _ = "sudo";
    };

    interactiveShellInit = ''
      set fish_greeting

      set -x fish_tmux_autostart false
      set -x fish_tmux_autostart_once false
      set -x fish_tmux_autoname_session true
      set -x fish_tmux_config "$HOME/.config/tmux/tmux.conf"

      set -x GTK2_RC_FILES "/usr/share/themes/Numix/gtk-2.0/gtkrc"
      set -x RUFF_EXPERIMENTAL_FORMATTER "True"
      set -x QT_QPA_PLATFORMTHEME gtk3
      set -x LANG en_US.UTF-8
      set -x XDG_CONFIG_HOME "$HOME/.config"
      set -x VISUAL "nvim"
      set -x EDITOR "nvim"
      set -x SUDO_EDITOR "nvim"
      set -x GPG_TTY (tty)
      set -x RANGER_DEVICONS_SEPARATOR "  "
      set -x GTK_THEME "Numix:dark"
      set -x PASSWORD_STORE_ENABLE_EXTENSIONS true
      set -x COMPOSE_BAKE true

      set --erase --universal fish_key_bindings

      set --global fish_color_autosuggestion brblack
      set --global fish_color_cancel -r
      set --global fish_color_command blue
      set --global fish_color_comment red
      set --global fish_color_cwd green
      set --global fish_color_cwd_root red
      set --global fish_color_end green
      set --global fish_color_error brred
      set --global fish_color_escape brcyan
      set --global fish_color_history_current --bold
      set --global fish_color_host normal
      set --global fish_color_host_remote yellow
      set --global fish_color_normal normal
      set --global fish_color_operator brcyan
      set --global fish_color_param cyan
      set --global fish_color_quote yellow
      set --global fish_color_redirection cyan --bold
      set --global fish_color_search_match white --background=brblack
      set --global fish_color_selection white --bold --background=brblack
      set --global fish_color_status red
      set --global fish_color_user brgreen
      set --global fish_color_valid_path --underline
      set --global fish_pager_color_completion normal
      set --global fish_pager_color_description yellow -i
      set --global fish_pager_color_prefix normal --bold --underline
      set --global fish_pager_color_progress brwhite --background=cyan
      set --global fish_pager_color_selected_background -r

      starship init fish | source
      zoxide init fish | source

      bind \cx\ce edit_command
      bind \co copy_current_command

      function tmux_pick
          sesh connect (
              sesh list --icons | fzf \
                --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
                --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
                --bind 'tab:down,btab:up' \
                --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
                --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
                --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
                --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
                --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
                --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
                --preview-window 'right:55%' \
                --preview 'sesh preview {}'
          )
      end

      function startwine
          env '/home/nik/.local/share/StartWine/data/runtime/sw'
      end
      function tp --wraps tmux
          tmux_pick $argv
      end
      function ddate --wraps date
          date -u +%Y-%m-%dT%H:%M:%S $argv
      end
      function ww --wraps ls
          ls *mkv | head -n 1 | tee $TTY | xargs -I {} mv {} {}_ $argv
      end
      function x --wraps extract
          extract $argv
      end
      function which-command --wraps whence
          whence $argv
      end

      set ___MY_VMOPTIONS_SHELL_FILE "$HOME/.jetbrains.vmoptions.sh"
      if test -f $___MY_VMOPTIONS_SHELL_FILE
          . $___MY_VMOPTIONS_SHELL_FILE
      end
    '';
  };

  xdg.configFile = {
    "fish/conf.d/aliases.fish" = {
      source = "${fishDir}/conf.d/aliases.fish";
    };
  }
  // lib.mapAttrs' (name: _: {
    name = "fish/functions/${name}";
    value = {
      source = "${fishDir}/functions/${name}";
    };
  }) (builtins.readDir "${fishDir}/functions")
  // lib.mapAttrs' (name: _: {
    name = "fish/completions/${name}";
    value = {
      source = "${fishDir}/completions/${name}";
    };
  }) (builtins.readDir "${fishDir}/completions")
  // lib.mapAttrs' (name: _: {
    name = "fish/functions/${name}";
    value = {
      source = "${fzfFishPlugin}/functions/${name}";
    };
  }) (builtins.readDir "${fzfFishPlugin}/functions")
  // {
    "fish/functions/bass.fish" = {
      source = "${bassPlugin}/functions/bass.fish";
    };
    "fish/functions/__bass.py" = {
      source = "${bassPlugin}/functions/__bass.py";
    };
    "fish/completions/fzf_configure_bindings.fish" = {
      source = "${fzfFishPlugin}/completions/fzf_configure_bindings.fish";
    };
  };
}
