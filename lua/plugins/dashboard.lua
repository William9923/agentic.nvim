-- Start screen: snacks.nvim dashboard only (same CODE header as the LazyVim setup).
local date = os.date("%d/%m/%y (%a) %X")

local function in_git()
  return Snacks.git.get_root() ~= nil
end

local function git_pane(title, cmd, height)
  return {
    pane = 2,
    icon = " ",
    title = title,
    section = "terminal",
    enabled = in_git,
    cmd = cmd,
    height = height,
    ttl = 5 * 60,
    indent = 2,
    gap = 1,
    padding = 1,
  }
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
      git_pane("Git Status", "git status --short", 7),
      git_pane("Git History", "git log --all --decorate --oneline --graph", 15),
    },
  },
})
