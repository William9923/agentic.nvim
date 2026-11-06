# NEOVIM CONFIG (native 0.12, no plugin-manager framework)

Plain Neovim >= 0.12: `vim.pack`, `vim.lsp.enable` + `after/lsp/<name>.lua`, ui2. Reading/review-focused for agentic coding.
All keymaps + capabilities: `KEYMAPS.md` (update it when you add/change a key).
Roadmap + verification per step: `~/vimwiki/specs/neovim-update.wiki`. Old LazyVim config: `~/.config/nvim-lazyvim-old`, tarball in `~/backups/`.

## STRUCTURE
- `init.lua` -> requires config.options, config.autocmds, config.keymaps, plugins, personal.dicipline
- `lua/config/` plain settings (options, autocmds, core keymaps)
- `lua/plugins/init.lua` the ONE `vim.pack.add` call, then requires group files (ui, git, treesitter, lsp, editor); `plugins/keymaps.lua` holds ALL plugin keymaps, required last
- `lua/utils/agent.lua` yank path#L / code block helpers for agents
- `after/lsp/<name>.lua` per-server settings (merged by Neovim)
- `nvim-pack-lock.json` tracked on purpose (reproducible plugin revs)

## RULES
- New plugin: add to `vim.pack.add`, configure in a group file, keymap in `plugins/keymaps.lua`.
- New LSP server: add name to `vim.lsp.enable` in `plugins/lsp.lua`; settings only in `after/lsp/`.
- Update plugins: `:lua vim.pack.update()`; reload: `ZR`.
- Check: `nvim --headless +qa` and `:verbose map <key>`.
