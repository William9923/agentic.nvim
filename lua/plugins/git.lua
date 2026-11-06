require("gitsigns").setup({
  current_line_blame = true,
  current_line_blame_opts = { virt_text = true, virt_text_pos = "eol", delay = 50 },
  current_line_blame_formatter = "<author> • <author_time:%Y-%m-%d> • <summary>",
})

require("codediff").setup({
  diff = { compact = true, compact_context_lines = 8 }, -- review mode: changes + 8 lines context
  explorer = { width = 50, auto_open_on_cursor = true, line_stats = { enabled = true } },
})
