function netcheck
    set -l ifs (nmcli -g DEVICE,TYPE device | grep ':wifi$' | cut -d: -f1)
    echo "== devices"; nmcli -t -f DEVICE,STATE,CONNECTION device | grep -E '^wl'
    echo "== default route"; ip route show default
    for i in $ifs
        printf "== %-16s link: " $i; iw dev $i link | grep -E 'freq|signal' | string trim | string join "  "
        printf "== %-16s gateway: " $i; ping -I $i -c 2 -W 1 172.20.10.1 >/dev/null 2>&1; and echo ok; or echo FAIL
        printf "== %-16s internet: " $i; ping -I $i -c 2 -W 1 1.1.1.1 >/dev/null 2>&1; and echo ok; or echo FAIL
    end
    printf "== dns: "; resolvectl query archlinux.org >/dev/null 2>&1; and echo ok; or echo FAIL
    printf "== NM connectivity: "; nmcli networking connectivity check
    echo "== recent wifi errors"; sudo dmesg | grep -iE 'rtw89|usb 3-.*(error|-71)' | tail -5
end
