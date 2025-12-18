function rename_to_snake_case
    for file in *.{mp3,flac,ogg,opus,m4a,wav}
        if test -f $file
            set ext (string match -r '\.([^.]+)$' $file)[2]
            set base (string replace -r '\.[^.]+$' '' $file)
            set new_base (string lower $base | string replace -a -r '[[:punct:]]' '' | string replace -a ' ' '_' | string replace -a '__' '_')
            mv $file "$new_base.$ext"
        end
    end
end
