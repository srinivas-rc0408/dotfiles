# Linux Customizations: Arch + niri

A minimal black and white glass desktop on Arch Linux, tuned for an ASUS TUF F15 (i7-11800H, RTX 3050 Ti, hybrid graphics).

## Stack

| Role | Tool |
|---|---|
| Compositor | niri 26.04 (scrollable tiling, Wayland) |
| Bar | Waybar |
| Launcher | rofi 2.0 (custom grid + quick actions) |
| Terminal | Ghostty + fish + starship + fastfetch |
| Notifications | swaync |
| Volume and brightness OSD | swayosd |
| Lock / power menu | hyprlock, wlogout |
| Cursor | S10-Pointer (custom, drawn from scratch) |
| Fallback desktop | KDE Plasma 6 |
| Bootloader | systemd-boot (linux + linux-lts) |

## Features

- **Launcher**: 3x3 app grid with hover-select and single-click launch, a random quote card, and a bolt button that switches to quick actions (performance profiles, screenshot, clipboard, lock, sleep, restart, power off).
- **Glass everywhere**: native niri background blur behind the launcher and power menu, a 1.5px white focus ring, no tinted window fill.
- **Power menu**: five identical glass tiles with a custom line-icon set, staggered entrance animation, hover lift, and a toggle on Win+X.
- **Custom cursor**: a pointing glove on a wooden stick, drawn on a 32x48 pixel grid so every edge is crisp. Source in cursor/S10-Pointer/source.svg.
- **Volume OSD**: a slim glass pill with a live percentage, 3 percent steps, and a hard cap at 100 percent.
- **Screenshots and recording**: niri area-select screenshots on PrtSc, region recording on Shift+PrtSc.
- **Automatic power modes**: Turbo on the charger (performance governor, ASUS Performance, NVIDIA Dynamic Boost), Balanced on battery, switched by udev and applied at boot.
- **WiFi failover**: a USB adapter carries traffic, the built-in card stays connected as a hot backup, and route metrics switch traffic instantly if the primary drops.
- **Memory**: zram as first-priority swap with swappiness tuned for it.

## Keybinds

| Keys | Action |
|---|---|
| Win + T | Terminal |
| Win + D | Launcher |
| Win + Q | Close window |
| Win + N | Notification center |
| Win + X | Power menu (press again to close) |
| Win + Alt + L | Lock |
| Win + Shift + V | Clipboard history |
| PrtSc / Ctrl + Win + S | Screenshot a selected area |
| Shift + PrtSc | Record a selected area (press again to stop) |
| Win + Shift + / | Show all keybinds |

## Problems I debugged

1. **System freezing with idle CPU.** Load average was 6.45 while the CPU sat 87 percent idle, with 12.7 percent I/O wait. Processes were stuck in uninterruptible sleep. dmesg showed the MT7921 WiFi driver in a loop of "driver own failed" and "chip reset failed": the chip was failing to wake from runtime power management and blocking kernel threads. Fix: disabled all four sleep layers (PCIe runtime PM through udev, chip runtime-pm and deep-sleep through a boot service, udev hook and resume hook, PCIe ASPM, WiFi power save), and disabled Windows Fast Startup, which leaves the chip in a state Linux cannot take over.
2. **Unreliable WiFi.** Built a primary and backup setup: two NetworkManager profiles bound by MAC address, with route metrics 100 and 600 so the kernel always prefers the USB adapter and fails over to the built-in card with no reconnect.
3. **Brown tint on transparent windows.** The niri focus ring is drawn as a filled shape behind the window, so a gold ring bled through a translucent terminal. Fix: draw-border-with-background false plus a thin white ring.
4. **Blur that looked like a separate desktop.** Niri blur defaults to xray mode, which shows only the wallpaper. Fix: xray off for overlays that must show live windows.
5. **Slow boot.** systemd-analyze showed 10 seconds spent in the bootloader menu, not in the system itself. Fix: loader timeout 2.

## Repo layout

    .config/        app configs (niri, rofi, waybar, swaync, swayosd, wlogout, ghostty, fish, ...)
    .local/bin/     launcher, quick-actions, screenrec
    cursor/         S10-Pointer cursor theme and its source SVG
    system/         /etc, /usr and /boot tweaks (review before copying)
    packages/       pacman, AUR and flatpak package lists
    install.sh      symlinks configs into place with automatic backups

## Install

    git clone https://github.com/srinivas-rc0408/Linux-Customizations-.git
    cd Linux-Customizations-
    sudo pacman -S --needed - < packages/pacman.txt
    ./install.sh

Install AUR packages from packages/aur.txt with your AUR helper. Files in system/ change system behaviour and some are hardware-specific (the WiFi rules match this laptop), so read each one before copying it into place.

Wallpapers and character images are not included. Add your own at ~/Pictures/wall.jpg, ~/Pictures/lock.jpg and ~/.config/rofi/hero.png.
