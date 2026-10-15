function fetch
    if test $COLUMNS -lt 70
        fastfetch --logo none
    else
        fastfetch --logo ~/.config/fastfetch/s10.txt --logo-type file \
                        --logo-color-1 "38;5;255" --logo-color-2 "38;5;253" --logo-color-3 "38;5;251" \
                        --logo-color-4 "38;5;249" --logo-color-5 "38;5;246" --logo-color-6 "38;5;243" \
                        --logo-color-7 "38;5;240" --logo-color-8 "38;5;237" \
                        --logo-padding-top 2 --logo-padding-left 4 --logo-padding-right 7
    end
end
