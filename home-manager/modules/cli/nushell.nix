_: {
  programs.nushell.enable = true;

  xdg.configFile = {
    "nushell/config.nu" = {
      force = true;
      text = ''
        const config_dir = $nu.default-config-dir
        const user_env_path = ($config_dir | path join "env.nu")
        const user_config_path = ($config_dir | path join "config.nu")
        const custom_completions = ($config_dir | path join ./modules/nu_scripts/custom-completions/)
        const module_nu_scripts = ($config_dir | path join ./modules/nu_scripts/)

        source aliases/common.nu
        source aliases/docker.nu
        source aliases/exa.nu
        source aliases/gh.nu
        source aliases/git.nu
        source aliases/pacman.nu
        source aliases/pre-commit.nu
        source aliases/rsync.nu
        source aliases/yay.nu
        source aliases/sing.nu

        source ($config_dir | path join "colors.nu")

        const cache_dir = $nu.cache-dir
        const carapace_dir = ($cache_dir | path join "carapace")
        const carapace_init = ($carapace_dir | path join "init.nu")
        mkdir $carapace_dir
        if not ($carapace_init | path exists) {
            carapace _carapace nushell | save --force $carapace_init
        }
        source $carapace_init

        const starship_dir = ($cache_dir | path join "starship")
        const starship_init = ($starship_dir | path join "init.nu")
        mkdir $starship_dir
        if not ($starship_init | path exists) {
            starship init nu | save --force $starship_init
        }
        source $starship_init

        const zoxide_dir = ($cache_dir | path join "zoxide")
        const zoxide_init = ($zoxide_dir | path join "init.nu")
        mkdir $zoxide_dir
        if not ($zoxide_init | path exists) {
            zoxide init nushell | save --force $zoxide_init
        }
        source $zoxide_init

        let fish_completer = {|spans|
            ^fish --command $"complete '--do-complete=($spans | str join ' ')'" e> /dev/null
            | from tsv --flexible --noheaders --no-infer
            | rename value description
            | update value {
                if ($in | path exists) {
                    $in
                    | str replace -a ' ' '\ '
                    | str replace -a '"' '\\"'
                } else {
                    $in
                }
            }
        }

        let carapace_completer = {|spans: list<string>|
          # 1. Перехватываем ввод: если ввели kubecolor, меняем первый элемент на kubectl
            let modified_spans = if ($spans.0 == "kubecolor") {
                $spans | skip 1 | prepend "kubectl"
            } else {
                $spans
            }

            # 2. Передаем в carapace наш модифицированный массив (modified_spans вместо spans)
            let raw = ( carapace $modified_spans.0 nushell ...$modified_spans | from json )
              
            let completions = (
                if ($raw | get value | into string | where $it =~ '^-.*ERR$' | is-empty) {
                    $raw
                } else {
                    []
                }
            )
            let completions_flat = (
                $completions
                | each {|item|
                    {
                        value: $item.value,
                        description: ($item | get -o description | default ""),
                        display: $item.display,
                        style: ($item | get -o style | default blue),
                    }
                }
            )
            $completions_flat
        }

        let external_completer = {|spans|
            let expanded_alias = (scope aliases | where name == $spans.0 | get -o 0 | get -o expansion | default null)
            let spans = if $expanded_alias != null {
                let parts = ($expanded_alias | split row ' ' | get -o 0)
                $spans | skip 1 | prepend $parts
            } else {
                $spans
            }
            let completer = match $spans.0 {
                nu => $fish_completer
                lima => $fish_completer
                nh => $fish_completer
                alembic => $fish_completer
                ssh => $fish_completer
                flux => $fish_completer
                limactl => $fish_completer
                sops => $fish_completer
                _ => $carapace_completer
            }
            do $completer $spans
        }

        $env.config = {
          show_banner: false
          edit_mode:  'vi'
          history: {
            max_size: 1000000
            sync_on_enter: true
            file_format: "sqlite"
            isolation: true
          }
          keybindings: [
            {
              name: edit_in_nvim
              modifier: CONTROL
              keycode: Char_e
              mode: [emacs vi_normal vi_insert]
              event: [
                { send: OpenEditor }
              ]
            }
            {
              name: clear_to_start
              modifier: CONTROL
              keycode: Char_u
              mode: [emacs vi_normal vi_insert]
              event: [
                { edit: Clear }
              ]
            }
            {
              name: reload_config
              modifier: none
              keycode: f5
              mode: [emacs vi_normal vi_insert]
              event: {
                send: executehostcommand,
                cmd: $"source '($user_env_path)';source '($user_config_path)'"
              }
            }
            {
              name: fzf_insert_path
              modifier: CONTROL
              keycode: Char_f
              mode: [emacs vi_normal vi_insert]
              event: {
                send: executehostcommand
                cmd: "let path = (fd --type f --type d --no-ignore | fzf --prompt='Path> '); if ($path | is-not-empty) { commandline edit --insert $path }"
              }
            }
          ]
          completions: {
            case_sensitive: false
            algorithm: "fuzzy"
            sort: "smart"
            partial: false
            quick: true
            external: {
              enable: true
              max_results: 40
              completer: $external_completer
            }
            use_ls_colors: true
          }
          menus: []
        }

        const atuin_dir = ($cache_dir | path join "atuin")
        const atuin_init = ($atuin_dir | path join "init.nu")
        mkdir $atuin_dir
        if not ($atuin_init | path exists) {
            atuin init nu | save --force $atuin_init
        }
        source $atuin_init

        use ($custom_completions | path join "bat/bat-completions.nu") *
        use ($custom_completions | path join "gh/gh-completions.nu") *
        use ($custom_completions | path join "git/git-completions.nu") *
        use ($custom_completions | path join "tar/tar-completions.nu") *
        use ($custom_completions | path join "pass/pass-completions.nu") *
        use ($custom_completions | path join "rg/rg-completions.nu") *
        use ($custom_completions | path join "nix/nix-completions.nu") *
        use ($module_nu_scripts | path join "modules/argx") *
        use ($module_nu_scripts | path join "modules/lg") *
        use ($module_nu_scripts | path join "modules/kubernetes") *
        use ($custom_completions | path join "uv/uv-completions.nu") *
        use ($module_nu_scripts | path join "modules/docker") *
      '';
    };

    "nushell/env.nu" = {
      force = true;
      text = ''
        $env.__zoxide_hooked = true
        $env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
        $env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }
        $env.FZF_DEFAULT_OPTS = "--color=fg:#f8f8f2,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"

        $env.IDEA_VM_OPTIONS = ($nu.home-dir | path join ".local/share/jetbra/jetbra/vmoptions/idea.vmoptions")
        $env.CLION_VM_OPTIONS = ($nu.home-dir | path join ".local/share/jetbra/jetbra/vmoptions/clion.vmoptions")
        $env.PHPSTORM_VM_OPTIONS = ($nu.home-dir | path join ".local/share/jetbra/jetbra/vmoptions/phpstorm.vmoptions")
        $env.GOLAND_VM_OPTIONS = ($nu.home-dir | path join ".local/share/jetbra/jetbra/vmoptions/goland.vmoptions")
        $env.PYCHARM_VM_OPTIONS = ($nu.home-dir | path join ".local/share/jetbra/jetbra/vmoptions/pycharm.vmoptions")
        $env.WEBSTORM_VM_OPTIONS = ($nu.home-dir | path join ".local/share/jetbra/jetbra/vmoptions/webstorm.vmoptions")
        $env.WEBIDE_VM_OPTIONS = ($nu.home-dir | path join ".local/share/jetbra/jetbra/vmoptions/webide.vmoptions")
        $env.RIDER_VM_OPTIONS = ($nu.home-dir | path join ".local/share/jetbra/jetbra/vmoptions/rider.vmoptions")
        $env.DATAGRIP_VM_OPTIONS = ($nu.home-dir | path join ".local/share/jetbra/jetbra/vmoptions/datagrip.vmoptions")
        $env.RUBYMINE_VM_OPTIONS = ($nu.home-dir | path join ".local/share/jetbra/jetbra/vmoptions/rubymine.vmoptions")
        $env.DATASPELL_VM_OPTIONS = ($nu.home-dir | path join ".local/share/jetbra/jetbra/vmoptions/dataspell.vmoptions")
        $env.AQUA_VM_OPTIONS = ($nu.home-dir | path join ".local/share/jetbra/jetbra/vmoptions/aqua.vmoptions")
        $env.RUSTROVER_VM_OPTIONS = ($nu.home-dir | path join ".local/share/jetbra/jetbra/vmoptions/rustrover.vmoptions")
        $env.GATEWAY_VM_OPTIONS = ($nu.home-dir | path join ".local/share/jetbra/jetbra/vmoptions/gateway.vmoptions")
        $env.JETBRAINS_CLIENT_VM_OPTIONS = ($nu.home-dir | path join ".local/share/jetbra/jetbra/vmoptions/jetbrains_client.vmoptions")
        $env.JETBRAINSCLIENT_VM_OPTIONS = ($nu.home-dir | path join ".local/share/jetbra/jetbra/vmoptions/jetbrainsclient.vmoptions")
        $env.STUDIO_VM_OPTIONS = ($nu.home-dir | path join ".local/share/jetbra/jetbra/vmoptions/studio.vmoptions")
        $env.DEVECOSTUDIO_VM_OPTIONS = ($nu.home-dir | path join ".local/share/jetbra/jetbra/vmoptions/devecostudio.vmoptions")


        $env.ENV_CONVERSIONS = {
          "PATH": {
            from_string: {|s| $s | split row (char esep) | path expand --no-symlink }
            to_string: {|v| $v | path expand --no-symlink | str join (char esep) }
          }
          "Path": {
            from_string: {|s| $s | split row (char esep) | path expand --no-symlink }
            to_string: {|v| $v | path expand --no-symlink | str join (char esep) }
          }
        }

        $env.NU_LIB_DIRS = [
          ($nu.default-config-dir | path join 'scripts')
          ($nu.data-dir | path join 'completions')
        ]

        $env.NU_PLUGIN_DIRS = [
          ($nu.default-config-dir | path join 'plugins')
        ]

        let hm_script = ($env.HOME | path join ".nix-profile/etc/profile.d/hm-session-vars.sh")
        let hm_cache = ($nu.cache-dir | path join "hm-session-vars.nuon")

        let hm_need_refresh = (
          not ($hm_cache | path exists)
          or (
            ($hm_script | path exists)
            and ((ls $hm_script | get 0.modified) > (ls $hm_cache | get 0.modified))
          )
        )

        let hm_vars = if $hm_need_refresh and ($hm_script | path exists) {
          let vars = (
            bash -c '
              env -i PATH=$PATH HOME=$HOME bash -c "
                source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
                env
              "
            '
          )
          | lines
          | split column '='
          | rename name value
          | where name != 'PATH'
          | where name != '_'
          | where name != 'PWD'
          | reduce -f {} {|row acc| $acc | upsert $row.name $row.value }

          $vars | save --force $hm_cache
          $vars
        } else if ($hm_cache | path exists) {
          open $hm_cache
        } else {
          {}
        }

        load-env $hm_vars
        $env.PATH = $env.PATH | append "/home/nik/.local/bin"
        $env.GTK2_RC_FILES = "/usr/share/themes/Numix/gtk-2.0/gtkrc"
        $env.RUFF_EXPERIMENTAL_FORMATTER = "True"
        $env.QT_QPA_PLATFORMTHEME = "gtk3"
        $env.LANG = "en_US.UTF-8"
        $env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
        $env.VISUAL = "nvim"
        $env.EDITOR = "nvim"
        $env.SUDO_EDITOR = "nvim"
        $env.GPG_TTY = (tty)
        $env.RANGER_DEVICONS_SEPARATOR = "  "
        $env.GTK_THEME = "Numix:dark"
        $env.PASSWORD_STORE_ENABLE_EXTENSIONS = true
        $env.COMPOSE_BAKE = true

        $env.TOPIARY_CONFIG_FILE = ($env.XDG_CONFIG_HOME | path join topiary languages.ncl)
        $env.TOPIARY_LANGUAGE_DIR = ($env.XDG_CONFIG_HOME | path join topiary languages)
        $env.OPENCODE_ENABLE_EXA = 1
        $env.OPENCODE_EXPERIMENTAL_LSP_TOOL = true
      '';
    };

    "nushell/colors.nu" = {
      force = true;
      text = ''
        let dark_theme = {
          separator: white
          leading_trailing_space_bg: { attr: n }
          header: green_bold
          empty: blue
          bool: light_cyan
          int: white
          filesize: cyan
          duration: white
          date: purple
          range: white
          float: white
          string: white
          nothing: white
          binary: white
          cell-path: white
          row_index: green_bold
          record: white
          list: white
          block: white
          hints: dark_gray
          search_result: { bg: red fg: white }
          shape_and: purple_bold
          shape_binary: purple_bold
          shape_block: blue_bold
          shape_bool: light_cyan
          shape_closure: green_bold
          shape_custom: green
          shape_datetime: cyan_bold
          shape_directory: cyan
          shape_external: cyan
          shape_externalarg: green_bold
          shape_external_resolved: light_yellow_bold
          shape_filepath: cyan
          shape_flag: blue_bold
          shape_float: purple_bold
          shape_garbage: { fg: white bg: red attr: b }
          shape_glob_interpolation: cyan_bold
          shape_globpattern: cyan_bold
          shape_int: purple_bold
          shape_internalcall: cyan_bold
          shape_keyword: cyan_bold
          shape_list: cyan_bold
          shape_literal: blue
          shape_match_pattern: green
          shape_matching_brackets: { attr: u }
          shape_nothing: light_cyan
          shape_operator: yellow
          shape_or: purple_bold
          shape_pipe: purple_bold
          shape_range: yellow_bold
          shape_record: cyan_bold
          shape_redirection: purple_bold
          shape_signature: green_bold
          shape_string: green
          shape_string_interpolation: cyan_bold
          shape_table: blue_bold
          shape_variable: purple
          shape_vardecl: purple
          shape_raw_string: light_purple
        }

        $env.config.color_config = $dark_theme
      '';
    };

    "nushell/aliases/common.nu" = {
      force = true;
      text = ''
        def --env r [...args] {
          let tmp = (mktemp -t "yazi-cwd.XXXXXX")
          yazi ...$args --cwd-file $tmp
          let cwd = (open $tmp)
          if $cwd != "" and $cwd != $env.PWD {
            cd $cwd
          }
          rm -fp $tmp
        }

        def vf [] {
          nvim (fd | fzf)
        }

        def --env take [dir: string] {
          mkdir $dir; cd $dir
        }

        def copy [file: string] {
          cat $file | to_clip
        }

        def t [] {
          sesh connect .
        }

        alias tpg = echo (cd (fd --hidden "^.git$" | sed -e 's/.git\///' | fzf); t)

        def tp [] {
          sesh connect (
            sesh list --icons | fzf
            --no-sort --ansi --border-label ' sesh ' --prompt '⚡  '
            --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find'
            --bind 'tab:down,btab:up'
            --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)'
            --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)'
            --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)'
            --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)'
            --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)'
            --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)'
            --preview-window 'right:55%'
            --preview 'sesh preview {}'
          )
        }

        def expand_alias [a: string@complete_alias] {
          scope aliases | where name == $a
        }

        def complete_alias [] {
          {
            completions: (
              scope aliases | each {|line|
                {
                  value: ($line | get name)
                  description: ($line | get expansion)
                }
              }
            )
          }
        }

        alias v = nvim
        alias se = sudoedit
        alias swo = nh os switch
        alias upd = nh os switch --update
        alias hms = nh home switch
        alias startwine = env ($env.HOME | path join .local/share/StartWine/data/runtime/sw)
        alias abs = readlink -f
        alias cat = bat
        alias md = mkdir
        alias rd = rmdir
        alias py = python
        alias prename = perl-rename
        alias grep = rg
        alias sortnr = sort -n -r
        alias tt = tail -f
        alias to_clip = xclip -sel clip
        alias x = xonsh
        alias k = kubecolor
        alias kx = kubectx
        alias ks = kubens
        alias c = codex
        alias d = devenv
        alias drag = ripdrag -a -x
      '';
    };

    "nushell/aliases/docker.nu" = {
      force = true;
      text = ''
        alias dbl =  env TERM="screen-256color" docker build
        alias dcb =  env TERM="screen-256color" docker compose build
        alias dcdn =  env TERM="screen-256color" docker compose down
        alias dce =  env TERM="screen-256color" docker compose exec
        alias dcin =  env TERM="screen-256color" docker container inspect
        alias dck =  env TERM="screen-256color" docker compose kill
        alias dcl =  env TERM="screen-256color" docker compose logs
        alias dclF =  env TERM="screen-256color" docker compose logs -f --tail 0
        alias dclf =  env TERM="screen-256color" docker compose logs -f
        alias dcls =  env TERM="screen-256color" docker container ls
        alias dclsa =  env TERM="screen-256color" docker container ls -a
        alias dco =  env TERM="screen-256color" docker compose
        alias dcps =  env TERM="screen-256color" docker compose ps
        alias dcpull =  env TERM="screen-256color" docker compose pull
        alias dcr =  env TERM="screen-256color" docker compose run
        alias dcrestart =  env TERM="screen-256color" docker compose restart
        alias dcrm =  env TERM="screen-256color" docker compose rm
        alias dcstart =  env TERM="screen-256color" docker compose start
        alias dcstop =  env TERM="screen-256color" docker compose stop
        alias dcup =  env TERM="screen-256color" docker compose up
        alias dcupb =  env TERM="screen-256color" docker compose up --build
        alias dcupd =  env TERM="screen-256color" docker compose up -d
        alias dcupdb =  env TERM="screen-256color" docker compose up -d --build
        alias dib =  env TERM="screen-256color" docker image build
        alias dii =  env TERM="screen-256color" docker image inspect
        alias dils =  env TERM="screen-256color" docker image ls
        alias dipu =  env TERM="screen-256color" docker image push
        alias dirm =  env TERM="screen-256color" docker image rm
        alias dit =  env TERM="screen-256color" docker image tag
        alias dlo =  env TERM="screen-256color" docker container logs
        alias dn =  env TERM="screen-256color" dotnet new
        alias dnc =  env TERM="screen-256color" docker network create
        alias dncn =  env TERM="screen-256color" docker network connect
        alias dndcn =  env TERM="screen-256color" docker network disconnect
        alias dng =  env TERM="screen-256color" dotnet nuget
        alias dni =  env TERM="screen-256color" docker network inspect
        alias dnls =  env TERM="screen-256color" docker network ls
        alias dnrm =  env TERM="screen-256color" docker network rm
        alias dp =  env TERM="screen-256color" dotnet pack
        alias dpo =  env TERM="screen-256color" docker container port
        alias dps =  env TERM="screen-256color" docker ps
        alias dpsa =  env TERM="screen-256color" docker ps -a
        alias dpu =  env TERM="screen-256color" docker pull
        alias dr =  env TERM="screen-256color" docker container run
        alias drit =  env TERM="screen-256color" docker container run -it
        alias drm =  env TERM="screen-256color" docker container rm
        alias 'drm!' =  env TERM="screen-256color" docker container rm -f
        alias drs =  env TERM="screen-256color" docker container restart
        alias dst =  env TERM="screen-256color" docker container start
        alias dsta =  env TERM="screen-256color" docker stop (docker ps -q)
        alias dstp =  env TERM="screen-256color" docker container stop
        alias dtop =  env TERM="screen-256color" docker top
        alias dvi =  env TERM="screen-256color" docker volume inspect
        alias dvls =  env TERM="screen-256color" docker volume ls
        alias dvprune =  env TERM="screen-256color" docker volume prune
        alias dxc =  env TERM="screen-256color" docker container exec
        alias dxcit =  env TERM="screen-256color" docker container exec -it
      '';
    };

    "nushell/aliases/exa.nu" = {
      force = true;
      text = ''
        alias tree = eza --tree
        alias l = eza -lhF
        alias lS = eza -1SshF
        alias la = eza -lAhF
        alias lart = eza -1cartF
        alias ldot = eza -ld .*
        alias ll = eza -l
        alias lr = eza -tRhF
        alias lrt = eza -1crtF
        alias lsa = ls -lah
        alias lsn = eza -1
        alias lsr = eza -lARhF
        alias lt = eza -lthF
      '';
    };

    "nushell/aliases/gh.nu" = {
      force = true;
      text = ''
        alias gh-create = gh repo create --public --source=. --remote=origin and git push -u --all and gh browse
        alias gh-create-private = gh repo create --private --source=. --remote=origin and git push -u --all and gh browse
      '';
    };

    "nushell/aliases/git.nu" = {
      force = true;
      text = ''
        def git_add [...files: string@complete_git_files --patch (-p)] {
          let args = [] | append (if $patch {'--patch'} else {[]})
          if ($files | is-empty) {
            git add ...$args .
          } else {
            git add ...$args ...$files
          }
        }

        def git_diff [...files: string@complete_git_files] {
            git diff ...$files
        }

        def gbdf --env [] {
          let sel = (^git branch --format='%(refname:short)' | fzf --multi)
          $sel | xargs -r git branch -d
        }

        def gbDf --env [] {
          let sel = (^git branch --format='%(refname:short)' | fzf --multi )
          $sel | xargs -r git branch -D
        }

        def complete_git_files [] {
          {
            options: {
              case_sensitive: false,
              positional: false,
              sort: false,
              algorithm: "fuzzy"
            },
            completions: (^git status --short | lines | where ($it | str length) > 3 |
              each { |line|
                {
                  value: ($line | str substring 3..)
                  description: ($line | str substring 0..2 | str replace ' ' '.')
                }
              }
            )
          }
        }

        alias g = git
        alias ga = git_add
        alias gaa = git add --all
        alias gam = git am
        alias gama = git am --abort
        alias gamc = git am --continue
        alias gams = git am --skip
        alias gamscp = git am --show-current-patch
        alias gap = git apply
        alias gapa = git add --patch
        alias gapt = git apply --3way
        alias gau = git add --update
        alias gav = git add --verbose
        alias gb = git branch
        alias gbD = git branch --delete --force
        alias gba = git branch --all
        alias gbd = git branch --delete
        alias gbl = git blame -w
        alias gbm = git branch --move
        alias gbnm = git branch --no-merged
        alias gbr = git branch --remote
        alias gbs = git bisect
        alias gbsb = git bisect bad
        alias gbsg = git bisect good
        alias gbsn = git bisect new
        alias gbso = git bisect old
        alias gbsr = git bisect reset
        alias gbss = git bisect start
        alias gc = git commit --verbose
        alias 'gc!' = git commit --verbose --amend
        alias gcB = git checkout -B
        alias gca = git commit --verbose --all
        alias 'gca!' = git commit --verbose --all --amend
        alias gcam = git commit --all --message
        alias 'gcan!' = git commit --verbose --all --no-edit --amend
        alias 'gcann!' = git commit --verbose --all --date=now --no-edit --amend
        alias 'gcans!' = git commit --verbose --all --signoff --no-edit --amend
        alias gcas = git commit --all --signoff
        alias gcasm = git commit --all --signoff --message
        alias gcb = git checkout -b
        alias gcf = git config --list
        alias gcl = git clone --recurse-submodules
        alias gclean = git clean --interactive -d
        alias gcmsg = git commit --message
        alias 'gcn!' = git commit --verbose --no-edit --amend
        alias gco = git checkout
        alias gcor = git checkout --recurse-submodules
        alias gcount = git shortlog --summary --numbered
        alias gcp = git cherry-pick
        alias gcpa = git cherry-pick --abort
        alias gcpc = git cherry-pick --continue
        alias gcs = git commit --gpg-sign
        alias gcsm = git commit --signoff --message
        alias gcss = git commit --gpg-sign --signoff
        alias gcssm = git commit --gpg-sign --signoff --message
        alias gd = git_diff
        alias gdca = git diff --cached
        alias gdct = git describe --tags (git rev-list --tags --max-count=1)
        alias gdcw = git diff --cached --word-diff
        alias gds = git diff --staged
        alias gdt = git diff-tree --no-commit-id --name-only -r
        alias gdup = git diff @{upstream}
        alias gdw = git diff --word-diff
        alias gf = git fetch
        alias gfa = git fetch --all --prune --jobs=10
        alias gfg = git ls-files | grep
        alias gfo = git fetch origin
        alias gg = git gui citool
        alias 'gga!' = git gui citool --amend
        alias ggpull = git pull origin "(git branch --show-current)"
        alias ggpur = ggu
        alias ggpush = git push origin "(git branch --show-current)"
        alias ggsup = git branch --set-upstream-to=origin/(git branch --show-current)
        alias ghh = git help
        alias gi = git-ignore
        alias gignore = git update-index --assume-unchanged
        alias gignored = git ls-files -v | rg "^[[:lower:]]"
        alias gl = git pull
        alias glg = git log --stat
        alias glgg = git log --graph
        alias glgga = git log --graph --decorate --all
        alias glgm = git log --graph --max-count=10
        alias glgp = git log --stat --patch
        alias glo = git log --oneline --decorate
        alias globurl = noglob urlglobber
        alias glod = git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"
        alias glods = git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short
        alias glog = git log --oneline --decorate --graph
        alias gloga = git log --oneline --decorate --graph --all
        alias glol = git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"
        alias glola = git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all
        alias glols = git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat
        alias glp = _git_log_prettily
        alias gluc = git pull upstream (git branch --show-current)
        alias gm = git merge
        alias gma = git merge --abort
        alias gmc = git merge --continue
        alias gms = git merge --squash
        alias gmtl = git mergetool --no-prompt
        alias gmtlvim = git mergetool --no-prompt --tool=vimdiff
        alias gp = git push
        alias gpd = git push --dry-run
        alias gpf = git push --force-with-lease --force-if-includes
        alias 'gpf!' = git push --force
        alias gpoat = git push origin --all and git push origin --tags
        alias gpod = git push origin --delete
        alias gpr = git pull --rebase
        alias gpra = git pull --rebase --autostash
        alias gprav = git pull --rebase --autostash -v
        alias gpristine = git reset --hard and git clean --force -dfx
        alias gprv = git pull --rebase -v
        alias gpsup = git push --set-upstream origin (git branch --show-current)
        alias gpsupf = git push --set-upstream origin (git branch --show-current) --force-with-lease --force-if-includes
        alias gpu = git push upstream
        alias gpv = git push --verbose
        alias gr = git remote
        alias gra = git remote add
        alias grb = git rebase
        alias grba = git rebase --abort
        alias grbc = git rebase --continue
        alias grbi = git rebase --interactive
        alias grbo = git rebase --onto
        alias grbs = git rebase --skip
        alias grev = git revert
        alias greva = git revert --abort
        alias grevc = git revert --continue
        alias grf = git reflog
        alias grh = git reset
        alias grhh = git reset --hard
        alias grhk = git reset --keep
        alias grhs = git reset --soft
        alias grm = git rm
        alias grmc = git rm --cached
        alias grmv = git remote rename
        alias groh = git reset origin/(git branch --show-current) --hard
        alias grrm = git remote remove
        alias grs = git restore
        alias grset = git remote set-url
        alias grss = git restore --source
        alias grst = git restore --staged
        alias grt = cd (git rev-parse --show-toplevel or echo .)
        alias gru = git reset --
        alias grup = git remote update
        alias grv = git remote --verbose
        alias gsb = git status --short --branch
        alias gsd = git svn dcommit
        alias gsh = git show
        alias gsi = git submodule init
        alias gsps = git show --pretty=short --show-signature
        alias gsr = git svn rebase
        alias gss = git status --short
        alias gst = git status
        alias gsta = git stash push
        alias gstaa = git stash apply
        alias gstall = git stash --all
        alias gstc = git stash clear
        alias gstd = git stash drop
        alias gstl = git stash list
        alias gstp = git stash pop
        alias gsts = git stash show --patch
        alias gstu = gsta --include-untracked
        alias gsu = git submodule update
        alias gsw = git switch
        alias gswc = git switch --create
        alias gta = git tag --annotate
        alias gtas = git tag --annotate --sign
        alias gtl = git tag --sort=-v:refname -n --list
        alias gts = git tag --sign
        alias gtv = git tag | sort -V
        alias gunignore = git update-index --no-assume-unchanged
        alias gunwip = git rev-list --max-count=1 --format="%s" HEAD | rg -q "--wip--" and git reset HEAD~1
        alias gwch = git whatchanged -p --abbrev-commit --pretty=medium
        alias gwipe = git reset --hard and git clean --force -df
        alias gwt = git worktree
        alias gwta = git worktree add
        alias gwtls = git worktree list
        alias gwtmv = git worktree move
        alias gwtrm = git worktree remove
      '';
    };

    "nushell/aliases/pacman.nu" = {
      force = true;
      text = ''
        alias pacfiles = pacman -F
        alias pacfileupg = sudo pacman -Fy
        alias pacin = sudo pacman -S
        alias pacins = sudo pacman -U
        alias pacinsd = sudo pacman -S --asdeps
        alias paclean = sudo pacman -Sc
        alias pacloc = pacman -Qi
        alias paclocs = pacman -Qs
        alias paclr = sudo pacman -Scc
        alias pacls = pacman -Ql
        alias paclsorphans = sudo pacman -Qdt
        alias pacmanallkeys = sudo pacman-key --refresh-keys
        alias pacmir = sudo pacman -Syy
        alias pacown = pacman -Qo
        alias pacre = sudo pacman -R
        alias pacrem = sudo pacman -Rns
        alias pacrep = pacman -Si
        alias pacreps = pacman -Ss
        alias pacrmorphans = sudo pacman -Rs (pacman -Qtdq)
        alias pacupd = sudo pacman -Sy
        alias pacupg = sudo pacman -Syu
      '';
    };

    "nushell/aliases/pre-commit.nu" = {
      force = true;
      text = ''
        alias prc = pre-commit
        alias prcau = pre-commit autoupdate
        alias prcr = pre-commit run
        alias prcra = pre-commit run --all-files
        alias prcrf = pre-commit run --files
      '';
    };

    "nushell/aliases/rsync.nu" = {
      force = true;
      text = ''
        alias rsync = rsync -avz --progress -h
        alias rsync = rsync -avz --progress -h --remove-source-files
        alias rsync = rsync -avzu --delete --progress -h
        alias rsync = rsync -avzu --progress -h
      '';
    };

    "nushell/aliases/sing.nu" = {
      force = true;
      text = ''
        alias sbr = sudo systemctl restart sing-box.service
        alias sbst = sudo systemctl stop sing-box.service
        alias sbs = sudo systemctl start sing-box.service
        alias sbe = nvim /etc/sing-box/config.json
      '';
    };

    "nushell/aliases/yay.nu" = {
      force = true;
      text = ''
        alias yaclean = yay -Sc
        alias yaclr = yay -Scc
        alias yaconf = yay -Pg
        alias yain = yay -S
        alias yains = yay -U
        alias yainsd = yay -S --asdeps
        alias yaloc = yay -Qi
        alias yalocs = yay -Qs
        alias yalst = yay -Qe
        alias yamir = yay -Syy
        alias yaorph = yay -Qtd
        alias yare = yay -R
        alias yarem = yay -Rns
        alias yarep = yay -Si
        alias yareps = yay -Ss
        alias yasu = yay -Syu --noconfirm
        alias yaupd = yay -Sy
        alias yaupg = yay -Syu
      '';
    };
  };
}
