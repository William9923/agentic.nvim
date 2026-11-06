-- Plain Neovim settings carried over from the LazyVim config (LazyVim-only globals dropped).
local opt = vim.opt

vim.scriptencoding = "utf-8"
opt.fileencoding = "utf-8"

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.tmux_navigator_no_mappings = 1
vim.g.tmux_navigator_save_on_switch = 2

opt.clipboard = "unnamedplus"
opt.fileformat = "dos"
opt.shell = "zsh"
opt.breakindent = true
opt.backspace = { "start", "eol", "indent" }
opt.cmdheight = 1
opt.completeopt = { "menuone", "noselect" }
opt.hlsearch = true
opt.backup = false
opt.ignorecase = true
opt.smartcase = true
opt.pumheight = 10
opt.showmode = false
opt.showtabline = 0
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.termguicolors = true
opt.timeoutlen = 1000
opt.undofile = true
opt.updatetime = 300
opt.writebackup = false
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.cursorline = true
opt.number = false
opt.relativenumber = true
opt.laststatus = 3
opt.showcmd = false
opt.ruler = true
opt.numberwidth = 4
opt.signcolumn = "yes"
opt.wrap = false
opt.whichwrap:append("<,>,[,],h,l")
opt.iskeyword:append("-")
opt.path:append({ "**" })
opt.wildignore:append({ "*/node_modules/*", "*/vendor/*", "statik.go" })
opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver75-Cursor,r-cr-o:hor20-Cursor"
opt.winborder = "rounded"

-- Folding (treesitter), persistent via mkview
opt.smoothscroll = true
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldmethod = "expr"
opt.foldlevel = 99
opt.foldlevelstart = 1
opt.foldnestmax = 4

vim.cmd([[
  augroup remember_folds
    autocmd!
    autocmd BufWinLeave *.* silent! mkview
    autocmd BufWinEnter *.* silent! loadview
  augroup end
]])

-- Experimental ui2 message/cmdline UI (Neovim 0.12)
require("vim._core.ui2").enable({})

-- vimwiki (must be set before the plugin loads)
vim.g.vimwiki_folding = ""
vim.g.vimwiki_auto_header = 1
vim.g.vimwiki_list = {
  { path = "~/vimwiki", syntax = "markdown", ext = ".md", diary_rel_path = "Daily Notes" },
  {
    path = "~/vimwiki/diary",
    index = "diary",
    syntax = "default",
    ext = ".wiki",
    diary_rel_path = "",
    diary_index = "diary",
    auto_diary_index = 1,
  },
}
