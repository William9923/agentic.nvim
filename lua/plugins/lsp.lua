-- Per-server settings live in after/lsp/<name>.lua; nvim-lspconfig supplies cmd/filetypes/roots.
require("mason").setup() -- also puts ~/.local/share/nvim/mason/bin on PATH

vim.lsp.enable({
  "lua_ls",
  "yamlls",
  "vtsls",
  "gopls", -- configured before
  "jdtls",
  "pyright",
  "ruff",
  "terraformls",
  "jsonls",
  "dockerls",
  "docker_compose_language_service", -- were LazyVim extras
})

vim.lsp.inlay_hint.enable(true)
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  virtual_text = { prefix = "●", source = "if_many" },
})
