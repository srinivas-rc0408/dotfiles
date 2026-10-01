function tidy
    echo "== before"; df -h / /home | tail -2
    set orphans (pacman -Qdtq); test -n "$orphans"; and sudo pacman -Rns $orphans
    sudo paccache -rk1; sudo paccache -ruk0
    flatpak uninstall --unused -y
    sudo journalctl --vacuum-size=200M
    sudo rm -rf /var/lib/systemd/coredump/*
    rm -rf ~/.cache/thumbnails ~/.cache/cliphist-thumbs ~/.cache/yay ~/.cache/paru ~/.npm/_cacache ~/.cargo/registry/cache
    rm -rf ~/.local/share/Trash/files/* ~/.local/share/Trash/info/*
    command -q uv; and uv cache clean
    command -q pip; and pip cache purge >/dev/null
    echo "== after"; df -h / /home | tail -2
    echo "== memory"; free -h | head -2
end
