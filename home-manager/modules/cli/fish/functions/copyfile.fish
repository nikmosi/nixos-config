function copyfile
  # Check if an argument is passed
  if test (count $argv) -eq 0
    echo "Usage: copyfile <path>"
    return 1
  end

  # Get the file path from the argument
  set -l file $argv[1]

  # Check if the file exists
  if not test -f $file
    echo "Error: File '$file' not found."
    return 1
  end

  # Copy the file contents to the clipboard
  if cat $file | clipcopy
    echo "Contents of '$file' copied to clipboard."
  else
    echo "Error: Failed to copy contents of '$file' to clipboard."
    return 1
  end
end

