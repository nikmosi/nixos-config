function fgst
    # Check if inside a git repository
    git rev-parse --git-dir > /dev/null 2>&1
    if test $status -ne 0
        echo "You are not in a git repository"
        return
    end

    # Use fzf to select files
    set selected (git -c color.status=always status --short | fzf --height 50% $argv --border -m --ansi --nth 2..,.. --preview 'git diff --color=always -- {-1} | sed 1,4d; cat {-1}' | cut -c4- | sed 's/.* -> //')

    # Open selected files in editor
    if test -n "$selected"
        for prog in $selected
            $EDITOR $prog
        end
    end
end

