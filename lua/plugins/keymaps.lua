-- All keymaps that need a plugin. Group files hold none.
local map = vim.keymap.set
local agent = require("utils.agent")

-- Per-change review (gitsigns): hunk by hunk inside the buffer
local gs = require("gitsigns")
local function nav(dir, key)
  return function()
    if vim.wo.diff then
      vim.cmd.normal({ key, bang = true })
    else
      gs.nav_hunk(dir)
    end
  end
end
map("n", "]c", nav("next", "]c"), { desc = "Next hunk" })
map("n", "[c", nav("prev", "[c"), { desc = "Prev hunk" })
map("n", "<leader>gp", gs.preview_hunk_inline, { desc = "Preview hunk inline (overlay)" })
map("n", "<leader>gP", gs.preview_hunk, { desc = "Preview hunk (float)" })
map("n", "<leader>gd", function()
  gs.toggle_deleted()
  gs.toggle_linehl()
  gs.toggle_word_diff()
end, { desc = "Toggle diff overlay" })
map("n", "<leader>gh", gs.stage_hunk, { desc = "Stage/unstage hunk" })
map("v", "<leader>gh", function()
  gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Stage/unstage selection" })
map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
map("n", "<leader>gs", gs.stage_buffer, { desc = "Stage buffer" })
map("n", "<leader>gb", function()
  gs.blame_line({ full = true })
end, { desc = "Blame line" })
map("n", "<leader>gB", gs.blame, { desc = "Blame buffer" })

-- Whole-change review (codediff)
map("n", "<leader>dv", "<cmd>CodeDiff<cr>", { desc = "CodeDiff: working tree" })
map("n", "<leader>dh", "<cmd>CodeDiff history %<cr>", { desc = "CodeDiff: file history" })
map("n", "<leader>dH", "<cmd>CodeDiff history<cr>", { desc = "CodeDiff: repo history" })

-- Agent context helpers
map("n", "<leader>yf", function()
  agent.yank_path(false)
end, { desc = "Yank rel path#L" })
map("n", "<leader>yp", function()
  agent.yank_path(true)
end, { desc = "Yank abs path#L" })
map("x", "<leader>cc", agent.yank_block, { desc = "Yank selection as code block" })

-- Reading code: LSP + pickers + tree (existing habits kept)
local fzf = require("fzf-lua")
map("n", ";f", fzf.files, { desc = "Find files" })
map("n", ";r", fzf.live_grep, { desc = "Grep" })
map("n", ";b", function()
  fzf.buffers({ sort_mru = true, sort_lastused = true })
end, { desc = "Buffers" })
map("n", ";d", fzf.diagnostics_document, { desc = "Document diagnostics" })
map("n", ";k", fzf.keymaps, { desc = "Keymaps" })
map("n", ";gc", fzf.git_commits, { desc = "Commits" })
map("n", ";gs", fzf.git_status, { desc = "Git status" })
map("n", "<leader>fg", fzf.git_files, { desc = "Git files" })
map("n", ";t", function()
  require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } })
end, { desc = "Todo/Fix/Fixme" })

map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "File tree" })
map("n", "<leader>a", "<cmd>Outline<cr>", { desc = "Outline" })

local ill = require("illuminate")
map("n", "]]", function()
  ill.goto_next_reference(false)
end, { desc = "Next reference" })
map("n", "[[", function()
  ill.goto_prev_reference(false)
end, { desc = "Prev reference" })

map("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })
map("n", "gy", vim.lsp.buf.type_definition, { desc = "Type definition" })
map("n", "gI", vim.lsp.buf.implementation, { desc = "Implementation" })
map("n", "gh", fzf.lsp_references, { desc = "References" })
map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })

-- K = LSP hover (default in 0.12). gK = full :help for the dotted name under cursor (vim.keymap.set, vim.api.nvim_*)
map("n", "gK", function()
  vim.opt_local.iskeyword:append(".")
  local word = vim.fn.expand("<cword>"):gsub("^vim%.api%.", ""):gsub("%.$", "")
  vim.opt_local.iskeyword:remove(".")
  for _, tag in ipairs({ word .. "()", word, vim.fn.expand("<cword>") }) do
    if pcall(vim.cmd.help, tag) then
      return
    end
  end
  vim.notify("No help for " .. word, vim.log.levels.WARN)
end, { desc = "Help for word under cursor" })
