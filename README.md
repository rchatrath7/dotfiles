# dotfiles

macOS bootstrap: apps, shell, editors, and AI tooling configs.

## Fresh machine setup (one command)

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/rchatrath7/dotfiles/HEAD/remote-install.sh)"
```

This clones the repo to `~/src/github.com/rchatrath7/dotfiles` and runs `install.sh`, which:

1. Installs Xcode CLT (if needed) and Homebrew
2. Installs everything in `Brewfile` (CLI tools, casks, fonts, GUI apps)
3. Clones oh-my-zsh and [gitz](https://github.com/rchatrath7/gitz) (your fork)
4. Symlinks all configs into place (existing files are backed up)
5. Sets up fzf key bindings, nvm + Node LTS + pnpm + sfw
6. Installs Neovim plugins headlessly via lazy.nvim

## What's included

| Dir        | Contents                                                        | Linked to                          |
|------------|-----------------------------------------------------------------|------------------------------------|
| `zsh/`     | `.zshrc`, `.zprofile`, `.zshenv`, custom zsh functions          | `~/`, `~/.config/zsh/functions`    |
| `git/`     | `.gitconfig` (SSH signing, aliases, LFS), global `.gitignore`   | `~/`                               |
| `nvim/`    | Neovim config (kickstart-based, lazy.nvim)                      | `~/.config/nvim`                   |
| `opencode/`| opencode config, AGENTS.md, rose-pine theme                     | `~/.config/opencode`               |
| `claude/`  | Claude Code settings, keybindings, CLAUDE.md, custom skills     | `~/.claude/` (skills individually) |
| `ghostty/` | Ghostty config                                                  | `~/.config/ghostty/config`         |
| `ripgrep/` | `.ripgreprc`                                                    | `~/`                               |
| `iterm/`   | iTerm2 profile + color schemes (import manually, not symlinked) | —                                  |

## Secrets (not in the repo)

- `SOCKET_API_KEY` — placeholder in `.zshrc`, fill in after install
- `FIREWORKS_API_KEY` — referenced as `{env:...}` in `opencode/opencode.json`
- SSH keys and `~/.ssh/allowed_signers` must be regenerated/copied manually

## Notes

- iTerm2: import `iterm/iterm-profile.json` via Settings → Profiles → Import.
- Claude Code plugins (`ralph-loop`) and synced skills reinstall automatically
  on first launch via `claude/settings.json`.
- `~/dotfiles` on the old machine was a stale 2024 clone — ignore it.
