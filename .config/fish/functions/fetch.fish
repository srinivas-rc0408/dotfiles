function fetch
    set -l logo ~/.config/fastfetch/s10.png
    if test $COLUMNS -lt 90; or not test -f $logo
        fastfetch --logo none
        return
    end
    set -l w (math "min(26, max(14, floor($COLUMNS / 6)))")
    set -l h (math "ceil($w * 0.31)")
    fastfetch --logo $logo --logo-type kitty-direct --logo-width $w --logo-height $h --logo-padding-top 1
end
