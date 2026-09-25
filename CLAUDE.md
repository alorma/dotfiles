# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository for macOS (zsh). It symlinks configuration files into `$HOME` and includes shell aliases/functions, git config, Homebrew packages, and macOS defaults.

## Installation

```bash
./install.sh           # symlinks dotfiles into $HOME, installs oh-my-zsh/p10k/fonts, calls the scripts below
./homebrew/install.sh   # installs Homebrew itself
brew bundle --file=homebrew/Brewfile  # installs packages/casks
./macos/set-defaults.sh # applies macOS system defaults (asked interactively from install.sh)
./java/install.sh       # installs sdkman (if missing) and pins the default Java version
```

## Structure

- `zsh/.zshrc` — entry point; sources `config.zsh` and `aliases.zsh`
- `zsh/.zsh/aliases.zsh` — all shell aliases and functions (Android, Gradle, git worktrees, etc.)
- `zsh/.zsh/config.zsh` — shell environment: editor, theme, fzf, nvm (lazy-loaded), Android SDK path
- `and/and.sh` — entry point for the `and` adb helper CLI; dispatches to `and/commands/*.sh` or shows an fzf menu when run bare
- `and/commands/` — one script per adb chore (`animations`, `screenshot`, `touch-pointer`, `font-size`, `talkback`, `navigation`, `paste`, `current-activity`, `fix-date`); each works standalone
- `and/lib/common.sh` — shared UI helpers for the `and` CLI (colours, fzf styling, `pick`, `banner`, spinners)
- `and/lib/device.sh` — adb device discovery/selection helpers shared by the `and` commands
- `git/.gitconfig` — git aliases, diff-so-fancy pager, SSH commit signing via 1Password
- `git/.gitignore_global` — global gitignore (includes machine-local files like `.claude/settings.local.json`)
- `git/github-open.sh` — opens the GitHub compare/PR page for the current branch; used by `git compare`/`git pr`
- `homebrew/Brewfile` — managed packages/casks, kept in sync with what's actually installed
- `java/install.sh` — installs sdkman and a pinned Java version
- `macos/set-defaults.sh` — interactive macOS system settings changes

## Machine-specific config

Add machine-specific overrides to `~/.localrc` — it is sourced automatically if it exists. Anything that shouldn't go to the public repo (e.g. work credential helpers in `.gitconfig`, work-specific `.gitignore_global` entries) is kept as local uncommitted changes or `git stash` entries instead of being committed.

## Key git aliases (from `.gitconfig`)

| Alias | Description |
|---|---|
| `g sw` | `git switch` |
| `g wip` / `g unwip` | quick WIP commit / soft reset |
| `g pushr` | push current branch to origin and track |
| `g roomba` | delete local branches whose remote is gone, skipping any checked out in a worktree |
| `g pullmaster` | fetch `master` into the local `master` ref without switching branches |
| `g rebmaster` / `g rebmain` | pull master/main and rebase current branch on top (`rebmaster` autostashes) |
| `g fixup <ref>` | amend an older commit interactively |
| `g pr` | push branch and open a GitHub PR |
| `g compare` | push branch and open the GitHub compare page |
| `g brf` | fuzzy-find local branches with fzf, preview log, copy name on enter |

## Key shell functions (from `aliases.zsh`)

- `gwt <branch>` / `gwtrm [-f]` — create/switch to a git worktree for a branch (local, remote, or new); remove the current worktree and its branch
- `and [command] [args]` — wraps `and/and.sh` (see below); adds the resolved one-liner to shell history when picked interactively
- `androidAppInfo <package>` / `openDeepLink <url>` — open the app details screen / a deep link via adb

## The `and` adb CLI

`and` (`and/and.sh`) is the single entry point for day-to-day adb chores. Run it bare for an fzf menu, or pass a subcommand to skip the prompt:

- `and animations {on,off,fast,slow}` — window/transition/animator scales
- `and screenshot [delay]` — capture every connected device to `~/Downloads`, with an optional countdown; uses the `android` CLI's `screen capture` when installed, falling back to plain `adb exec-out screencap`
- `and touch-pointer {on,off}` — show/hide touch indicators
- `and font-size <scale>` — system font scale
- `and talkback toggle` — toggle the TalkBack accessibility service
- `and navigation {gestures,buttons}` — switch nav bar mode
- `and paste` — type the clipboard contents into the device
- `and current-activity` — print the foreground activity class
- `and fix-date` — sync the emulator clock to the host

Each command also works standalone (`and/commands/<name>.sh`). Shared UI (colours, fzf menu, spinners) lives in `and/lib/common.sh`; device discovery in `and/lib/device.sh`.
