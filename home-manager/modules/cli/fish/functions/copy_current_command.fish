function copy_current_command
    set current_command (commandline -p)
    echo -n "$current_command" | xclip -sel clip
end
