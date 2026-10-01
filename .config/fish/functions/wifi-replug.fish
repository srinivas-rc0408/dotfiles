function wifi-replug
    sudo modprobe -r rtw89_8851bu_git rtw89_8852bu rtw89_8851b_git rtw89_8852b_git rtw89_8852b_common_git rtw89_usb_git rtw89_core_git 2>/dev/null
    sudo usbreset 3625:010b 2>/dev/null
    sudo modprobe rtw89_8851bu_git
    sleep 4
    sudo /usr/local/bin/mt7921-nopm
    nmcli connection up "iPhone (dongle)"
    nmcli device status | grep wl
end
