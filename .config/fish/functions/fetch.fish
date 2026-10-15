function fetch
    if test $COLUMNS -lt 70
        fastfetch --logo none
    else
        fastfetch --logo ~/.config/fastfetch/s10.txt --logo-type file --logo-color-1 97 --logo-color-2 37 --logo-color-3 90 --logo-padding-top 6 --logo-padding-left 2 --logo-padding-right 6
    end
end
