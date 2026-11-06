-- Core keymaps (no plugin dependency). Plugin keymaps live in plugins/keymaps.lua.
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", ".", ";", opts)
keymap("v", ".", ";", opts)

keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)
keymap("n", "<S-q>", "<cmd>bdelete!<CR>", opts)
keymap("n", "<C-s>", ":w<CR>", opts)
keymap({ "n", "v" }, "<C-a>", "gg<S-v>G", opts)
keymap("n", "r", "R", opts)
keymap("n", "+", "<C-a>", opts)
keymap("n", "-", "<C-x>", opts)
keymap("n", "te", ":tabedit<CR>", opts)

keymap("n", "<leader>ss", ":split<Return><C-w>w", opts)
keymap("n", "<leader>sv", ":vsplit<Return><C-w>w", opts)
keymap("n", "<leader>sq", "<C-w>q", opts)

keymap({ "n", "v" }, "<CR>", "i<CR><esc>", opts)
keymap("i", "kk", "<ESC>", opts)

keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "<S-j>", ":m .+1<CR>==gv", opts)
keymap("v", "<S-k>", ":m .-2<CR>==gv", opts)
keymap("x", "<S-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<S-k>", ":move '<-2<CR>gv-gv", opts)

keymap({ "n", "x" }, "<leader>z", ":let&l:fdl=indent('.')/&sw<cr>", opts)

-- Reload config, keep session (new in 0.12). Save first: unsaved buffers block :restart.
keymap("n", "ZR", "<cmd>wa<bar>restart<CR>", { desc = "Save all + restart" })
