function __fish_pytest_complete
    set -x _ARGCOMPLETE 1
    set -x _ARGCOMPLETE_DFS \t
    set -x _ARGCOMPLETE_IFS \n
    set -x _ARGCOMPLETE_SUPPRESS_SPACE 1
    set -x _ARGCOMPLETE_SHELL fish
    set -x COMP_LINE (commandline -p)
    set -x COMP_POINT (string length (commandline -cp))
    
    # Check if the last argument is a directory and use built-in completion
    set last_arg (commandline -cp | awk '{if ($0 ~ / $/) print " "; else print $NF}')
    if not test (string sub -l 1 -- "$last_arg") = "-"
        return
    end

    # If not, run the pytest completion logic
    if set -q _ARC_DEBUG
        pytest 8>&1 9>&2 1>&9 2>&1
    else
        pytest 8>&1 9>&2 1>/dev/null 2>&1
    end
end

complete --command pytest -a '(__fish_pytest_complete)'

