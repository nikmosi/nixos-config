function extract --description "Extract various archive types"
    set -l remove_archive 1
    if test (count $argv) -eq 0
        echo "Usage: extract [-option] [file ...]" >&2
        echo "" >&2
        echo "Options:" >&2
        echo "    -r, --remove    Remove archive after unpacking." >&2
        return 1
    end

    if test "$argv[1]" = "-r" -o "$argv[1]" = "--remove"
        set remove_archive 0
        set argv (commandline -cp | tail -n +2)
    end

    set -l pwd (pwd)
    for file in $argv
        if test ! -f $file
            echo "extract: '$file' is not a valid file" >&2
            continue
        end

        set -l success 0
        set -l full_path (realpath $file)
        set -l extract_dir (basename $file | sed 's/\.[^.]*$//')

        if string match -r '\.tar$' $extract_dir
            set extract_dir (basename $extract_dir .tar)
        end

        if test -e $extract_dir
            set -l rnd (echo (math (random) * 36) | base32 | string sub -l 5)
            set extract_dir "$extract_dir-$rnd"
        end

        mkdir -p $extract_dir
        cd $extract_dir
        echo "extract: extracting to $extract_dir" >&2

        switch (string lower $file)
            case '*.tar.gz' '*.tgz'
                if command -v pigz > /dev/null
                    tar -I pigz -xvf $full_path
                else
                    tar zxvf $full_path
                end
            case '*.tar.bz2' '*.tbz' '*.tbz2'
                if command -v pbzip2 > /dev/null
                    tar -I pbzip2 -xvf $full_path
                else
                    tar xvjf $full_path
                end
            case '*.tar.xz' '*.txz'
                if command -v pixz > /dev/null
                    tar -I pixz -xvf $full_path
                else
                    if tar --xz --help > /dev/null 2>&1
                        tar --xz -xvf $full_path
                    else
                        xzcat $full_path | tar xvf -
                    end
                end
            case '*.tar.zma' '*.tlz'
                if tar --lzma --help > /dev/null 2>&1
                    tar --lzma -xvf $full_path
                else
                    lzcat $full_path | tar xvf -
                end
            case '*.tar.zst' '*.tzst'
                if tar --zstd --help > /dev/null 2>&1
                    tar --zstd -xvf $full_path
                else
                    zstdcat $full_path | tar xvf -
                end
            case '*.tar'
                tar xvf $full_path
            case '*.tar.lz'
                if command -v lzip > /dev/null
                    tar xvf $full_path
                end
            case '*.tar.lz4'
                lz4 -c -d $full_path | tar xvf -
            case '*.tar.lrz'
                if command -v lrzuntar > /dev/null
                    lrzuntar $full_path
                end
            case '*.gz'
                if command -v pigz > /dev/null
                    pigz -cdk $full_path > (basename $file .gz)
                else
                    gunzip -ck $full_path > (basename $file .gz)
                end
            case '*.bz2'
                if command -v pbzip2 > /dev/null
                    pbzip2 -d $full_path
                else
                    bunzip2 $full_path
                end
            case '*.xz'
                unxz $full_path
            case '*.lrz'
                if command -v lrunzip > /dev/null
                    lrunzip $full_path
                end
            case '*.lz4'
                lz4 -d $full_path
            case '*.lzma'
                unlzma $full_path
            case '*.z'
                uncompress $full_path
            case '*.zip' '*.war' '*.jar' '*.ear' '*.sublime-package' '*.ipa' '*.ipsw' '*.xpi' '*.apk' '*.aar' '*.whl'
                unzip $full_path
            case '*.rar'
                unrar x -ad $full_path
            case '*.rpm'
                rpm2cpio $full_path | cpio --quiet -id
            case '*.7z' '*.7z.[0-9]*'
                7za x $full_path
            case '*.deb'
                mkdir -p control data
                ar vx $full_path > /dev/null
                cd control; extract ../control.tar.*
                cd ../data; extract ../data.tar.*
                cd ..
                rm *.tar.* debian-binary
            case '*.zst'
                unzstd --stdout $full_path > (basename $file .zst)
            case '*.cab' '*.exe'
                cabextract $full_path
            case '*.cpio' '*.obscpio'
                cpio -idmvF $full_path
            case '*.zpaq'
                zpaq x $full_path
            case '*.zlib'
                zlib-flate -uncompress < $full_path > (basename $file .zlib)
            case '*'
                echo "extract: '$file' cannot be extracted" >&2
                set success 1
        end

        if test $success -eq 0 -a $status -eq 0 -a $remove_archive -eq 0
            rm $full_path
        end

        cd $pwd

        set -l content (find $extract_dir -mindepth 1 -maxdepth 1)
        if test (count $content) -eq 1 -a -e $content[1]
            if test (basename $content[1]) = $extract_dir
                set -l tmp_name (mktemp -u)
                mv $content[1] $tmp_name
                rmdir $extract_dir
                mv $tmp_name $extract_dir
            else if test ! -e (basename $content[1])
                mv $content[1] .
                rmdir $extract_dir
            end
        else if test (count $content) -eq 0
            rmdir $extract_dir
        end
    end
end

