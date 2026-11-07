# Keymaps and capabilities

Leader = `<Space>`. Source of truth is the code: core keys in `lua/config/keymaps.lua`, plugin keys in `lua/plugins/keymaps.lua`.
Live list: `;k` (fzf keymaps) or `:verbose map <key>`.

## Reading code (LSP, all lists open in fzf-lua; one result jumps directly)

| Key | Action |
|-----|--------|
| `K` | hover docs (LSP); press again to enter the float, `q` closes |
| `gK` | full `:help` for the dotted name under cursor (`vim.keymap.set`, `vim.api.nvim_*`) |
| `gd` / `gD` | definition / declaration |
| `gy` | type definition |
| `gI` | implementations |
| `gr` or `gh` | references |
| `gO` | document symbols (replaces the outline sidebar) |
| `<leader>ls` | workspace symbols |
| `<leader>la` | code action (n, v) |
| `<leader>lr` | rename |
| `]e` / `[e` | next / prev ERROR (with float) |
| `]d` / `[d` | next / prev diagnostic, any severity (Neovim default) |
| `<C-w>d` | diagnostics under cursor (Neovim default) |
| `]]` / `[[` | next / prev reference of word under cursor (illuminate); `<M-n>` / `<M-p>` same |
| `;d` | document diagnostics (fzf) |
| `;t` | TODO / FIX / FIXME (fzf) |

Servers: lua_ls, gopls, jdtls, vtsls (+Vue), yamlls, pyright + ruff, terraformls, jsonls, dockerls, docker_compose. Inlay hints on.
Server settings: `after/lsp/<name>.lua`. Add a server: `vim.lsp.enable` in `lua/plugins/lsp.lua`. Install binaries: `:Mason`.

## Reviewing agent changes (git)

Per hunk, inside the buffer (gitsigns):

| Key | Action |
|-----|--------|
| `]c` / `[c` | next / prev hunk (native in diff windows) |
| `<leader>gp` | preview hunk inline (overlay) |
| `<leader>gP` | preview hunk in a float |
| `<leader>gd` | toggle diff overlay (deleted lines, line hl, word diff) |
| `<leader>gh` | stage / unstage hunk (visual: selection) |
| `<leader>gr` | reset hunk |
| `<leader>gs` | stage buffer |
| `<leader>gb` / `<leader>gB` | blame line (full) / blame buffer |

Whole change (codediff.nvim, compact mode = changes + 8 lines context, explorer 50 cols):

| Key | Action |
|-----|--------|
| `<leader>dv` | CodeDiff working tree (explorer + side-by-side) |
| `<leader>dh` | history of current file |
| `<leader>dH` | repo history |
| in the diff view | `<cr>` open file, `]c`/`[c` hunk, `]f`/`[f` file, `gc` toggle compact, `t` toggle inline/side-by-side, `-` stage file, `<leader>hs`/`hu`/`hr` stage/unstage/discard hunk, `q` close, `g?` help |

Fzf git: `;gs` status, `;gc` commits, `<leader>fg` git files. Dashboard shows git status + log.

## Handing context to an agent

| Key | Action |
|-----|--------|
| `<leader>yf` (n, visual) | copy `relative/path#L<line>`; visual = `#L<a>-<b>` range |
| `<leader>yp` (n, visual) | same with the absolute path |
| `<leader>cc` (visual) | copy selection as a fenced block with `filename="..." line=a-b` |

## Finding things

| Key | Action |
|-----|--------|
| `;f` | files |
| `;r` | live grep |
| `;b` | buffers (MRU) |
| `;k` | keymaps |
| `<leader>e` | file tree (neo-tree; `o` = open, `<space>` unmapped) |
| `<leader>ww` / `<leader>wt` | vimwiki index / in new tab |

## Editing habits (carried over)

| Key | Action |
|-----|--------|
| `kk` (insert) | `<Esc>` |
| `.` | repeat last `f/t` search (`;` is a prefix now) |
| `n` / `N`, `<C-d>` / `<C-u>` | keep cursor centered |
| `<CR>` | insert a newline, stay in normal mode |
| `r` | replace mode (`R`) |
| `+` / `-` | increment / decrement number |
| `<C-s>` | save |
| `<C-a>` | select all |
| `Q` (`<S-q>`) | delete buffer (`:bdelete!`) |
| `<leader>/` | toggle comment (line; visual = selection). Native `gc` / `gcc` also work |
| `<leader>h` | clear search highlight |
| `<leader>z` | fold to current indent |
| `<leader>ff` | format buffer (visual mode: selected range; LSP fallback) |
| `v` `<` `>` | indent and stay selected; `J` / `K` move selected lines |
| `te` | new tab |
| `<leader>ss` / `sv` / `sq` | split / vsplit / close window |
| `<C-h/j/k/l>` | move between windows and tmux panes; `<C-\>` last, `<C-Space>` next |
| `j k h l + -` | `dicipline`: warns after 30 repeats in 1.5s |
| `ZR` | save all + `:restart` (reload config, keep session) |

## Neovim 0.12 built-ins worth knowing

`gc` / `gcc` comment (native; `mini.comment` is not installed; `<leader>/` is a shortcut to them), `gx` open URL/file, `]b`/`[b` buffers, `]q`/`[q` quickfix,
`]<Space>`/`[<Space>` blank line, `<C-s>` in insert = signature help (the `<C-s>` normal map above is save),
`:restart`, `:Inspect`, `:InspectTree`, `:lsp`, `:checkhealth`. ui2 handles messages/cmdline.
Removed on purpose: Neovim's `grr gra grn gri grt grx` (replaced by `gr` / `gI` / `<leader>l*`).

## Commands

`:CodeDiff` (+ `history`, `install`), `:Neotree`, `:FzfLua <picker>`, `:Mason`, `:ConformInfo`,
`:lua vim.pack.update()` (review, then `:write` to confirm; `:quit` to discard), `:TSUpdate`, `:Gitsigns <cmd>`.

## Capabilities (what is installed)

| Area | Plugin |
|------|--------|
| plugin manager | built-in `vim.pack` (`nvim-pack-lock.json` tracked) |
| colors / ui | kanagawa-dragon, lualine, incline (filename tag), devicons, snacks.nvim (dashboard only), ui2 |
| syntax | nvim-treesitter (main) + treesitter folding |
| LSP | nvim-lspconfig + built-in `vim.lsp`, mason.nvim |
| formatting | conform.nvim (stylua, goimports, ruff; LSP fallback; Go/Python on save) |
| navigation | fzf-lua, neo-tree, vim-illuminate, nvim-tmux-navigation, todo-comments |
| git review | gitsigns, codediff.nvim, `utils/agent.lua` |
| notes | vimwiki |

## Not available yet

Completion (step 6), neotest, lazygit float, rust-analyzer.
Dropped from the LazyVim setup: ai_notes (`<leader>an/al/ad`), `;l` Lazy dashboard, noice.
