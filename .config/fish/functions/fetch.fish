function fetch
    if test $COLUMNS -lt 70
        fastfetch --logo none
    else
        fastfetch --logo ~/.config/fastfetch/s10.txt --logo-type file --logo-color-1 default \
                        --logo-padding-top 3 --logo-padding-left 3 --logo-padding-right 6
    end
end
