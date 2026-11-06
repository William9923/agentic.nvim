-- Helpers to hand context from Neovim to a coding agent.
local M = {}

local function copy(text)
  vim.fn.setreg("+", text)
  vim.notify("Copied: " .. text)
end

--- Path (relative to cwd, or absolute) + #L<line>, or #L<a>-<b> for a visual selection
function M.yank_path(absolute)
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then
    return vim.notify("No file name", vim.log.levels.WARN)
  end
  local path = absolute and vim.fn.fnamemodify(name, ":p") or vim.fn.fnamemodify(name, ":.")
  local range = "#L" .. vim.fn.line(".")
  if vim.fn.mode():match("^[vV\22]") then
    local a, b = vim.fn.line("v"), vim.fn.line(".")
    range = a == b and "#L" .. a or ("#L%d-%d"):format(math.min(a, b), math.max(a, b))
    vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
  end
  copy(path .. range)
end

--- Visual selection as ```<ft> filename="..." line=a-b fenced block
function M.yank_block()
  local a, b = vim.fn.line("v"), vim.fn.line(".")
  local s, e = math.min(a, b), math.max(a, b)
  local lines = vim.api.nvim_buf_get_lines(0, s - 1, e, false)
  local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
  local range = s == e and tostring(s) or (s .. "-" .. e)
  vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
  copy(('```%s filename="%s" line=%s\n%s\n```'):format(vim.bo.filetype, name, range, table.concat(lines, "\n")))
end

return M
