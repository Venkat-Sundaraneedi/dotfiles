function extract
    if count "$argv" < 1
        echo "Usage: extract <file>" >&2
        return 1
    end

    set -l file "$argv[1]"

    if test -f "$file"
        switch "$file"
            case '*.tar.bz2'
                tar xjf "$file"
            case '*.tar.gz'
                tar xzf "$file"
            case '*.bz2'
                bunzip2 "$file"
            case '*.rar'
                unrar x "$file"
            case '*.gz'
                gunzip "$file"
            case '*.tar'
                tar xf "$file"
            case '*.tbz2'
                tar xjf "$file"
            case '*.tgz'
                tar xzf "$file"
            case '*.zip'
                unzip "$file"
            case '*.Z'
                uncompress "$file"
            case '*'
                echo "'$file' cannot be extracted" >&2
                return 1
        end
    else
        echo "'$file' is not a valid file" >&2
        return 1
    end
end
