require("fzf-lua").setup({})
require("todo-comments").setup({})

require("illuminate").configure({
  delay = 150,
  large_file_cutoff = 1000,
  large_file_overrides = { providers = { "lsp" } },
  under_cursor = true,
  providers = { "lsp", "treesitter" },
  filetypes_denylist = { "neo-tree", "fzf", "vimwiki" },
})
vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "LspReferenceText" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "LspReferenceRead" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "LspReferenceWrite" })

local no_o = { "oc", "od", "og", "om", "on", "os", "ot" }
local function tree_mappings()
  local m = { ["<space>"] = "none", ["o"] = { "open_drop", nowait = true } }
  for _, k in ipairs(no_o) do
    m[k] = "none"
  end
  return m
end
require("neo-tree").setup({
  sources = { "filesystem", "buffers", "git_status", "document_symbols" },
  filesystem = {
    bind_to_cwd = false,
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = true,
  },
  buffers = { window = { mappings = tree_mappings() } },
  git_status = { window = { position = "float", mappings = tree_mappings() } },
  window = {
    width = 25,
    mapping_options = { noremap = false, nowait = true, silent = true },
    mappings = tree_mappings(),
  },
  default_component_configs = {
    indent = {
      with_expanders = true,
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
  },
})
