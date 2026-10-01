function bt
    switch "$argv[1]"
        case on;  rfkill unblock bluetooth; sudo systemctl start bluetooth; echo "Bluetooth on"
        case off; sudo systemctl stop bluetooth; rfkill block bluetooth; echo "Bluetooth off"
        case '*'; rfkill list | grep -A2 -i bluetooth
    end
end
