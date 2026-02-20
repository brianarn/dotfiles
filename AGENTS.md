# AGENTS.md — brianarn/dotfiles

Personal dotfiles for Brian Sinclair. This repo manages shell configuration,
editor settings, and tool configs via symlinks from `home/` into `$HOME`.

## Commands

- **Install**: `./install.sh` (or `./install.sh install`)
- **Update submodules**: `./install.sh update`
- **Health check**: `./scripts/doctor.sh`
- **Migration from stow**: `./scripts/migrate.sh`
- **Dry-run any command**: append `--dry-run`

There are no test, lint, or typecheck commands.

## Repo Structure

```
home/           Dotfiles symlinked into $HOME (mirrors target directory structure)
  .config/      XDG config (amp, direnv, git, nvim, starship)
  .vim/         Vim runtime files (after/, colors/, plug.vim)
  .zshrc        Primary shell config (oh-my-zsh, fzf, tinted-shell)
  .tmux.conf    Tmux configuration
  ...           Other dotfiles (.bashrc, .bash_profile, .vimrc, etc.)
copy/           Files copied (not symlinked) to allow machine-local edits
  gitconfig     Merged into ~/.gitconfig using a cutstring separator
  vimrc.local   Copied only if missing — local vim overrides
  vimplug.local Copied only if missing — local vim-plug additions
external/       Git submodules
  oh-my-zsh/    Zsh framework
  fzf/          Fuzzy finder
  tinted-shell/ Terminal color schemes (base16/base24, migrated from base16-shell)
  spaceship-prompt/  Zsh prompt theme
misc/           Extras not symlinked automatically
  custom-omz-themes/ Custom oh-my-zsh themes (symlinked by post-update)
  Actions.moom  Moom window manager config
scripts/        Install helpers and utilities
  lib.sh        Shared functions (logging, linking, merging, flag parsing)
  post-update.sh  Post-install tasks (theme symlinks, fzf install, pnpm completion)
  migrate.sh    One-time migration from old GNU Stow layout
  doctor.sh     Health checker — reports broken symlinks, missing tools, etc.
  tmux-battery.sh  Battery indicator for tmux status bar (macOS)
old-stow-trash/ Remnants of old stow-based directory layout (can be removed)
```

## How Installation Works

1. **Submodules** are initialized (`git submodule update --init`)
2. **Symlinks** are created: every file/directory in `home/` gets symlinked to its
   corresponding path under `$HOME` (e.g., `home/.zshrc` → `~/.zshrc`,
   `home/.config/nvim/init.vim` → `~/.config/nvim/init.vim`). Directories in `home/`
   become real directories in `$HOME`; only files and nested symlinks are linked.
3. **Dead symlinks** pointing into `home/` are pruned
4. **Copied files**: `gitconfig` is merged using a cutstring pattern (content above
   "DO NOT EDIT BELOW THIS LINE" is preserved as local config); `vimrc.local` and
   `vimplug.local` are copied only if they don't already exist
5. **Vim directories** (`~/.vim/tmp/{backup,swap,undo}`) are created
6. **Post-update tasks**: spaceship and brianarn themes are symlinked into oh-my-zsh,
   fzf is installed, pnpm completion is generated

## Conventions

### Adding a New Dotfile

Place the file in `home/` mirroring the target path under `$HOME`:

- `home/.tool-config` → symlinked to `~/.tool-config`
- `home/.config/tool/config.toml` → symlinked to `~/.config/tool/config.toml`

Run `./install.sh` to create the symlink. Parent directories are created automatically.

### Files That Need Local Customization

If a file needs per-machine edits (credentials, machine-specific paths), put it in
`copy/` instead. Use `copy_if_missing` for files that should only be seeded once, or
`merge_cutstring` for files that need both managed and local sections.

### Submodules

External tools live in `external/` as git submodules. To add a new one:

```bash
git submodule add <url> external/<name>
```

If it needs post-install wiring (like theme symlinks), add the logic to
`scripts/post-update.sh` in the `run_post_update` function.

### Shell Configuration

- Primary shell: **zsh** via oh-my-zsh (spaceship theme)
- `.zshrc.local.before` and `.zshrc.local` are sourced if they exist (for
  machine-local config not tracked in the repo)
- Color theming uses **tinted-shell** (base16/base24 themes)

## Guidelines for Making Changes

- **Don't hardcode absolute paths** in dotfiles — use `$HOME` or `$DOTFILES_ROOT`
  (set in `scripts/lib.sh`)
- **Preserve the home/ directory structure** — it must mirror `$HOME` exactly
- **Keep scripts/lib.sh functions generic** — they're shared across install, migrate,
  and doctor scripts
- **Use `--dry-run`** to preview changes before running install or migrate
- **Run `./scripts/doctor.sh`** after changes to verify everything is healthy
- **Don't commit machine-specific content** — use the `.local` file pattern
  (`.zshrc.local`, `.vimrc.local`) for per-machine overrides
