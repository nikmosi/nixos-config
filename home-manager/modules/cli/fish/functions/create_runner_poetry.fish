function create_runner_poetry
    if test -z $argv[1]
        echo "don't specify run file" 1>&2
        return
    end
    echo (poetry env info --executable) (readlink -f $argv[1]) "\"\$@\"" >> runner.sh
    chmod +x runner.sh
end
