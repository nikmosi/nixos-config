function wait_for_process
    # List running processes with full command lines
    # Format: PID and full command
    set processes (ps -eo pid,cmd --sort=cmd)

    # Use fzf to allow user to select a process
    set selected_process (string join \n $processes | fzf --prompt="Select a process: " --height=20 --border --ansi)

    # Check if a process was selected
    if test -z "$selected_process"
        echo "No process selected. Exiting."
        return 1
    end

    # Extract PID from the selected process (first field in output)
    set pid (echo $selected_process | awk '{print $1}')

    echo "Waiting for process with PID $pid to exit..."

    # Wait for the process to exit
    while kill -0 $pid > /dev/null 2>&1
        sleep 1
    end

    echo "Process with PID $pid has exited."
end

