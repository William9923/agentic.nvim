-- Start screen: snacks.nvim dashboard only (same CODE header as the LazyVim setup).
local date = os.date("%d/%m/%y (%a) %X")

local function in_git()
  return Snacks.git.get_root() ~= nil
end

-- Plain text pane instead of a snacks terminal: a terminal prints "[Process exited N]" and shows
-- git's stderr. Here a failing or slow git just yields an empty pane (always "exit 0").
-- shortcut: runs synchronously (1.5s cap); upgrade to async if huge repos slow startup.
local function git_pane(title, cmd, empty_text)
  return function()
    if not in_git() then
      return {}
    end
    local ok, res = pcall(function()
      return vim.system(cmd, { text = true, timeout = 1500 }):wait()
    end)
    local lines = {}
    if ok and res.code == 0 then
      lines = vim.split(vim.trim(res.stdout or ""), "\n", { trimempty = true })
    end
    if #lines == 0 then
      lines = { empty_text }
    end
    local items = { { pane = 2, icon = " ", title = title, padding = 1 } }
    for _, line in ipairs(lines) do
      items[#items + 1] = { pane = 2, text = { { "  " .. vim.fn.strcharpart(line, 0, 56), hl = "SnacksDashboardDesc" } } }
    end
    items[#items].padding = 1
    return items
  end
end

require("snacks").setup({
  dashboard = {
    pane_gap = 10,
    preset = {
      header = [[





    ██████╗ ██████╗ ██████╗ ███████╗
   ██╔════╝██╔═══██╗██╔══██╗██╔════╝
   ██║     ██║   ██║██║  ██║█████╗  
   ██║     ██║   ██║██║  ██║██╔══╝  
██╗╚██████╗╚██████╔╝██████╔╝███████╗
╚═╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
    by: William Ong


      ]] .. "\nDate: " .. date .. "\n",
      keys = {
        { icon = " ", key = "f", desc = "Find File", action = "<cmd>FzfLua files<cr>" },
        { icon = " ", key = "r", desc = "Find Text", action = "<cmd>FzfLua live_grep<cr>" },
        { icon = "󰒲 ", key = "u", desc = "Update plugins", action = "<cmd>lua vim.pack.update()<cr>" },
        { icon = " ", key = "q", desc = "Quit", action = "<cmd>qa<cr>" },
      },
    },
    sections = {
      { section = "header", gap = 2, padding = 1, height = 15 },
      { pane = 1, section = "keys", gap = 1, padding = 1 },
      -- snacks' "startup" section needs lazy.nvim; show the vim.pack plugin count instead
      function()
        return { pane = 1, align = "center", text = { { "⚡ " .. #vim.pack.get() .. " plugins", hl = "footer" } } }
      end,
      git_pane("Git Status", { "git", "status", "--short" }, "clean"),
      git_pane("Git History", { "git", "log", "--all", "--decorate", "--oneline", "--graph", "-n", "15" }, "no commits yet"),
    },
  },
})
