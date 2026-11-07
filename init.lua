-- Native Neovim >= 0.12 setup: vim.pack + vim.lsp.enable, no plugin manager framework.
-- Reading-focused setup.
vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.autocmds")
require("config.keymaps")
require("plugins") -- installs + configures plugins, then loads plugin keymaps last
require("personal.dicipline").norepeat()
