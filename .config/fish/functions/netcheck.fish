function netcheck
    echo "== devices"; nmcli -t -f DEVICE,STATE,CONNECTION device | grep -E 'wl'
    echo "== default routes"; ip route show default
    for i in wlp0s20f0u1i2 wlp46s0
        printf "== %-14s gateway: " $i; ping -I $i -c 2 -W 1 172.20.10.1 >/dev/null 2>&1; and echo ok; or echo FAIL
        printf "== %-14s internet: " $i; ping -I $i -c 2 -W 1 1.1.1.1 >/dev/null 2>&1; and echo ok; or echo FAIL
    end
    printf "== dns: "; getent hosts archlinux.org >/dev/null; and echo ok; or echo FAIL
    printf "== NM connectivity: "; nmcli networking connectivity check
    echo "== recent wifi errors"; sudo dmesg | grep -iE 'rtw89|mt7921|usb 3-.*(error|-71)' | tail -5
end
