local aug = vim.api.nvim_create_augroup("snorlax", { clear = true })
local au = vim.api.nvim_create_autocmd

au("FileType", {
  group = aug,
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

au("BufEnter", {
  group = aug,
  callback = function()
    vim.cmd("hi LineNrAbove guifg=red ctermfg=red")
    vim.cmd("hi LineNrBelow guifg=cyan ctermfg=cyan")
  end,
})

au("TextYankPost", {
  group = aug,
  callback = function()
    vim.hl.on_yank()
  end,
})
