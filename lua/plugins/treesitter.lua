vim.filetype.add({ extension = { mdx = "mdx" } })
vim.treesitter.language.register("markdown", "mdx")

local parsers = {
  "go",
  "gomod",
  "gowork",
  "gosum",
  "python",
  "rst",
  "toml",
  "terraform",
  "hcl",
  "regex",
  "markdown",
  "markdown_inline",
  "ruby",
  "gitignore",
  "typescript",
  "rust",
  "sql",
  "html",
  "javascript",
  "json",
  "tsx",
  "bash",
  "lua",
  "vim",
  "dockerfile",
  "vue",
  "css",
  "yaml",
}
require("nvim-treesitter").install(parsers) -- async, no-op for installed parsers

local no_indent = { toml = true, yaml = true, python = true, css = true }
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    if pcall(vim.treesitter.start, ev.buf) and not no_indent[ev.match] then
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
