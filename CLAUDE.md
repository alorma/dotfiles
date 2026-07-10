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
| `g roomba` | delete local branches whose remote is gone |
| `g rebmaster` / `g rebmain` | pull master/main and rebase current branch on top |
| `g fixup <ref>` | amend an older commit interactively |
| `g pr` | push branch and open a GitHub PR |
| `g compare` | push branch and open the GitHub compare page |
| `g brf` | fuzzy-find local branches with fzf, preview log, copy name on enter |

## Key shell functions (from `aliases.zsh`)

- `gwt <branch>` / `gwtrm [-f]` — create/switch to a git worktree for a branch (local, remote, or new); remove the current worktree and its branch
- `androidAnimations{On,Off,Fast,Slow}` — toggle Android emulator animation scales via adb
- `androidScreenshot [delay]` — capture screenshot from all connected devices to `~/Downloads`, with an optional countdown
- `androidTalkBackToggle` — toggle TalkBack accessibility service
- `androidPaste` — type the clipboard contents into the connected device via adb
- `androidFontSize{1,085,115,130}` — set system font scale
- `androidFixEmulatorDate` — sync emulator date/time to the host's
