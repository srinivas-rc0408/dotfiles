function sethero
    if not test -f "$argv[1]"
        echo "❌ Not found: $argv[1]"
        return 1
    end
    magick "$argv[1]" -trim +repage -resize x360 ~/.config/rofi/hero.png
    echo "✅ Hero image updated"
end
