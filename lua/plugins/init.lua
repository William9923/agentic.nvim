local gh = function(repo)
  return "https://github.com/" .. repo
end

-- must exist before vim.pack.add so the first install/update also builds parsers
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local d = ev.data
    if d.spec.name == "nvim-treesitter" and d.kind ~= "delete" then
      if not d.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

vim.pack.add({
  -- ui
  gh("rebelot/kanagawa.nvim"),
  gh("nvim-tree/nvim-web-devicons"),
  gh("nvim-lualine/lualine.nvim"),
  gh("b0o/incline.nvim"),
  gh("alexghergh/nvim-tmux-navigation"),
  gh("folke/snacks.nvim"), -- dashboard only
  -- git review
  gh("lewis6991/gitsigns.nvim"),
  gh("esmuellert/codediff.nvim"),
  -- syntax + lsp
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
  gh("neovim/nvim-lspconfig"),
  gh("mason-org/mason.nvim"),
  gh("stevearc/conform.nvim"),
  -- navigate / read
  gh("ibhagwan/fzf-lua"),
  gh("nvim-lua/plenary.nvim"),
  gh("MunifTanjim/nui.nvim"),
  { src = gh("nvim-neo-tree/neo-tree.nvim"), version = vim.version.range("3") },
  gh("RRethy/vim-illuminate"),
  gh("folke/todo-comments.nvim"),
  -- notes
  { src = gh("vimwiki/vimwiki"), version = "v2023.04.04_1" },
})

require("plugins.ui")
require("plugins.dashboard")
require("plugins.git")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.formatting")
require("plugins.editor")
require("plugins.keymaps") -- last: every plugin is set up by now
