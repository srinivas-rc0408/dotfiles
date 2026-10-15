function fetch
    if test $COLUMNS -lt 70
        fastfetch --logo none
    else
        fastfetch --logo ~/.config/fastfetch/s10.txt --logo-type file --logo-color-1 97 \
                        --logo-padding-top 2 --logo-padding-left 4 --logo-padding-right 7
    end
end
