#!/usr/bin/env bash
set -euo pipefail
repo="$(cd "$(dirname "$0")" && pwd)"
stamp="$(date +%Y%m%d-%H%M%S)"
mkdir -p "$HOME/.config" "$HOME/.local/bin" "$HOME/.local/share/icons"
for src in "$repo"/.config/*; do
  name="$(basename "$src")"; dest="$HOME/.config/$name"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then mv "$dest" "$dest.backup-$stamp"; echo "backed up $name"; fi
  ln -sfn "$src" "$dest"; echo "linked    $name"
done
for s in "$repo"/.local/bin/*; do ln -sfn "$s" "$HOME/.local/bin/$(basename "$s")"; done
ln -sfn "$repo/cursor/S10-Pointer" "$HOME/.local/share/icons/S10-Pointer"
echo
echo "Done. Files in system/ are not installed automatically. Review and copy them by hand."
