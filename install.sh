#!/usr/bin/env bash
#
# Bootstrap a fresh macOS machine from these dotfiles.
#
# One-liner (clones the repo, then runs this script):
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/rchatrath7/dotfiles/HEAD/remote-install.sh)"
#
# Or from a local clone:
#   ./install.sh
#
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33mWARN:\033[0m %s\n' "$*"; }

# Symlink helper: backs up any existing real file/dir, then links.
link() {
  local src="$1" dst="$2"
  if [ ! -e "$src" ]; then
    warn "missing source: $src (skipping)"
    return
  fi
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "$dst.bak.$(date +%Y%m%d%H%M%S)"
    warn "backed up existing $dst"
  fi
  ln -sfn "$src" "$dst"
  info "linked $dst -> $src"
}

# --- 1. Xcode Command Line Tools -------------------------------------------
if ! xcode-select -p &>/dev/null; then
  info "Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "Re-run this script after the CLT installer finishes."
  exit 0
fi

# --- 2. Homebrew -------------------------------------------------------------
if ! command -v brew &>/dev/null; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

info "Installing packages from Brewfile..."
brew bundle --file="$DOTFILES_DIR/Brewfile" || warn "some Brewfile entries failed; re-run 'brew bundle' later"

# --- 3. oh-my-zsh + gitz ------------------------------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  info "Installing oh-my-zsh..."
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
fi

if [ ! -d "$HOME/.gitz" ]; then
  info "Installing gitz..."
  git clone --depth=1 https://github.com/rchatrath7/gitz.git "$HOME/.gitz"
fi

# --- 4. Config symlinks ------------------------------------------------------
info "Linking configs..."

# zsh
link "$DOTFILES_DIR/zsh/.zshrc"            "$HOME/.zshrc"
link "$DOTFILES_DIR/zsh/.zprofile"         "$HOME/.zprofile"
link "$DOTFILES_DIR/zsh/.zshenv"           "$HOME/.zshenv"
link "$DOTFILES_DIR/zsh/functions"         "$HOME/.config/zsh/functions"

# git
link "$DOTFILES_DIR/git/.gitconfig"        "$HOME/.gitconfig"
link "$DOTFILES_DIR/git/.gitignore"        "$HOME/.gitignore"

# ripgrep
link "$DOTFILES_DIR/ripgrep/.ripgreprc"    "$HOME/.ripgreprc"

# neovim
link "$DOTFILES_DIR/nvim"                  "$HOME/.config/nvim"

# ghostty
link "$DOTFILES_DIR/ghostty/config"        "$HOME/.config/ghostty/config"

# opencode
link "$DOTFILES_DIR/opencode"              "$HOME/.config/opencode"

# claude code (files + individual skills, so app-managed dirs stay untouched)
link "$DOTFILES_DIR/claude/settings.json"    "$HOME/.claude/settings.json"
link "$DOTFILES_DIR/claude/CLAUDE.md"        "$HOME/.claude/CLAUDE.md"
link "$DOTFILES_DIR/claude/keybindings.json" "$HOME/.claude/keybindings.json"
for skill in "$DOTFILES_DIR"/claude/skills/*/; do
  link "${skill%/}" "$HOME/.claude/skills/$(basename "$skill")"
done

# --- 5. fzf shell integration --------------------------------------------------
if [ ! -f "$HOME/.fzf.zsh" ] && command -v fzf &>/dev/null; then
  info "Installing fzf key bindings..."
  "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
fi

# --- 6. Node via nvm, plus global CLIs -----------------------------------------
if [ ! -d "$HOME/.nvm" ]; then
  info "Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1091
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
if command -v nvm &>/dev/null; then
  info "Installing Node LTS + pnpm + sfw..."
  nvm install --lts
  corepack enable
  npm install -g sfw || warn "sfw install failed; install it manually (npm i -g sfw)"
  # opencode plugin deps
  if command -v npm &>/dev/null && [ -f "$HOME/.config/opencode/package.json" ]; then
    (cd "$HOME/.config/opencode" && npm install) || warn "opencode npm install failed"
  fi
else
  warn "nvm not available; skipping Node setup"
fi

# --- 7. Neovim plugins -----------------------------------------------------------
if command -v nvim &>/dev/null; then
  info "Installing Neovim plugins (lazy.nvim)..."
  nvim --headless "+Lazy! sync" +qa || warn "nvim plugin sync failed; run :Lazy sync manually"
fi

# --- Done -----------------------------------------------------------------------
cat <<'EOF'

Done! Remaining manual steps:

  1. Set your secrets:
       - SOCKET_API_KEY in ~/.zshrc
       - FIREWORKS_API_KEY in your shell env (used by ~/.config/opencode/opencode.json)
  2. Set up SSH keys + allowed_signers for commit signing (~/.ssh/id_ed25519).
     See ~/setup-git-ssh-signing.sh on your old machine if you still have it.
  3. Log into apps: 1Password, Slack, Notion, Linear, Docker, gh auth login, etc.
  4. iTerm2: import iterm/iterm-profile.json via Settings > Profiles > Import.
  5. Restart your shell (or run: exec zsh).

EOF
