# Neovim configuration

A personal, reading-focused Neovim setup built for native Neovim **0.12+**. It uses Neovim's built-in `vim.pack` and LSP support—no plugin-manager framework.

## Features

- LSP navigation, diagnostics, and inlay hints
- Treesitter highlighting and folding
- Git change review with Gitsigns and CodeDiff
- Fuzzy finding, file browsing, and formatting
- Keymaps and capabilities documented in [`KEYMAPS.md`](KEYMAPS.md)

## Requirements

- Neovim 0.12 or newer and Git
- `zsh` (the configured shell), plus language servers and formatters for the languages you use

Plugins install on first launch. Language servers and formatters are not installed automatically; use `:Mason` or your system package manager. The config also uses `~/vimwiki` for notes; change that in `lua/config/options.lua` if needed.

## Install

Back up or move any existing `~/.config/nvim`, then clone this repository there:

```sh
git clone https://github.com/William9923/agentic.nvim.git ~/.config/nvim
nvim
```

Plugin revisions are tracked in `nvim-pack-lock.json`. To update plugins, run `:lua vim.pack.update()`, review the changes, and save the lock file.

## Customize

Start with `lua/config/` for core settings and `lua/plugins/` for plugin setup. Plugin keymaps live in `lua/plugins/keymaps.lua`.
