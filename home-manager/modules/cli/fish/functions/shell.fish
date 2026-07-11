function shell
    function cut
        set name $argv[1]
        echo $name | sed -E 's/:.*//; s/[*-]+\s+//; s/^\s+//; s/\s+$//'
        functions -e inner_func
    end

    set env $argv[1]

    if test "$env"
        eval (pdm venv activate $env)
        return 0
    end

    set envs (pdm venv list | sed -n '/-/p')
    set envs_count (count $envs)
    
    if test $envs_count -eq 0
        echo "no venvs"
        return 1
    end
    
    if test $envs_count -eq 1
        set env $envs[1]
    end
    
    if test $envs_count -gt 1
        set env (printf "%s\n" $envs | fzf)
    end

    echo spawn $env
    set env (cut $env)
    fish -C "eval (pdm venv activate '$env')"
end

