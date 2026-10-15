function fetch
    if test $COLUMNS -lt 70
        fastfetch --logo none
    else
        fastfetch --logo ~/.config/fastfetch/s10.txt --logo-type file \
                        --logo-color-1 "38;5;255" --logo-color-2 "38;5;253" --logo-color-3 "38;5;250" \
                        --logo-color-4 "38;5;247" --logo-color-5 "38;5;244" --logo-color-6 "38;5;241" \
                        --logo-color-7 "38;5;238" \
                        --logo-padding-top 3 --logo-padding-left 2 --logo-padding-right 5
    end
end
