#!/usr/bin/env bash
# Remote bootstrap: clone the dotfiles repo and run install.sh.
# Usage:
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/rchatrath7/dotfiles/HEAD/remote-install.sh)"
set -euo pipefail

REPO="https://github.com/rchatrath7/dotfiles.git"
DEST="$HOME/src/github.com/rchatrath7/dotfiles"

if [ ! -d "$DEST/.git" ]; then
  mkdir -p "$(dirname "$DEST")"
  git clone "$REPO" "$DEST"
else
  git -C "$DEST" pull --ff-only || echo "WARN: could not fast-forward $DEST; using existing checkout" >&2
fi

exec "$DEST/install.sh"
