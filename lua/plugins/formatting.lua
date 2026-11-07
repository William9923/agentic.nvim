require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports" },
    python = { "ruff_format" },
  },
})
