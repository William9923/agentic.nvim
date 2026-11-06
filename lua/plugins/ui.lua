vim.cmd.colorscheme("kanagawa-dragon")

require("lualine").setup({ options = { theme = "kanagawa" } })

-- filename tag per window (one global statusline)
require("incline").setup({
  highlight = {
    groups = {
      InclineNormal = { guibg = "cyan", guifg = "black" },
      InclineNormalNC = { guifg = "magenta", guibg = "black" },
    },
  },
  window = { margin = { vertical = 0, horizontal = 1 } },
  render = function(props)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
    if vim.bo[props.buf].modified then
      filename = "[+] " .. filename
    end
    local icon, color = require("nvim-web-devicons").get_icon_color(filename)
    return { { icon, guifg = color }, { " " }, { filename } }
  end,
})

require("nvim-tmux-navigation").setup({
  disable_when_zoomed = true,
  keybindings = {
    left = "<C-h>",
    down = "<C-j>",
    up = "<C-k>",
    right = "<C-l>",
    last_active = "<C-\\>",
    next = "<C-Space>",
  },
})
