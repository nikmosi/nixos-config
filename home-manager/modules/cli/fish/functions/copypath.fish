function copypath
  # If no argument passed, use current directory
  set -l file (test (count $argv) -eq 0; and echo "."; or echo $argv[1])

  # If argument is not an absolute path, prepend $PWD
  if not string match -q '/*' $file
    set file "$PWD/$file"
  end

  # Copy the absolute path without resolving symlinks
  # If clipcopy fails, exit the function with an error
  if not echo -n $file | xclip -selection clipboard
    return 1
  end

  echo -e (set_color --bold) $file (set_color normal) "copied to clipboard."
end

