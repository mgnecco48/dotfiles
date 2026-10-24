-- ========================
-- = MARTIN GNECCO CONFIG =
-- ========================

-- TODO: add the git work plugin
-- TODO: place the notifications config properly in its own file
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Python host for Molten's remote plugin support.

-- vim.g.python3_host_prog = "/opt/miniconda3/envs/nvim-jupyter/bin/python" -- Not sure why i used this before

-- vim.g.python3_host_prog = "/home/martin/.conda/envs/nvim-jupyter" -- for mac, using conda
vim.g.python3_host_prog = "/home/martin/.venvs/nvim-jupyter/bin/python" --for linux, using uv
-- this is specific to my machine, change it to the path of your Python 3 interpreter if you want to use Molten's Jupyter support.

-- disabling netrw because it conflicts with neotree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- plugins are managed via 'lazy.nvim'
require("config.lazy")

-- background for different windows
vim.g.have_nerd_font = true
vim.opt.termguicolors = true
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.o.winborder = "rounded"
vim.o.inccommand = "split"

--- Miscellaneous
vim.o.number = true
vim.o.relativenumber = true
vim.o.showmode = false
vim.o.undofile = true
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = "↪"
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 1
vim.o.scrolloff = 10
vim.opt.fillchars = { eob = " " }
vim.o.laststatus = 3

--- notifications system
require("notify").setup({
  background_colour = "#111333",
  minimum_width = 15,
  timeout = 1000,
  stages = "slide",
  top_down = false,
  merge_duplicates = true,
})

vim.notify = require("notify")

-- Syncs the system clipboard to Nvim's allowing to copy and paste to/from other applications
vim.opt.clipboard = "unnamedplus" --this works locally only
-- Configuring a clipboard provider in the case of working in a remote environment via SSH.
-- This allows me to copy from the remote machine into the local machine's clipboard.
if vim.env.SSH_TTY then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end

-- Making searching with '/' non-case sensitive
vim.o.ignorecase = true
vim.o.smartcase = true

-- KEYMAPS
require("config.special_keymaps") --- Separate file for complex keymaps that would make this config too messy
-- Toggleing the Markdonw renderer plugin
vim.keymap.set("n", "<leader>md", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle RenderMarkdown" })

-- Move current line up/down in Normal mode
vim.keymap.set("n", "<S-Down>", ":m .+1<CR>", { desc = "Move line down" })
vim.keymap.set("n", "<S-Up>", ":m .-2<CR>", { desc = "Move line up" })

-- Move current line up/down in Insert mode
vim.keymap.set("i", "<S-Down>", "<Esc>:m .+1<CR>gi", { desc = "Move line down" })
vim.keymap.set("i", "<S-Up>", "<Esc>:m .-2<CR>gi", { desc = "Move line up" })

-- Move visually selected blocks up/down with automatic re-selection
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Reloading the config file (this file)
vim.keymap.set("n", "<leader>,", "<cmd>source $MYVIMRC<CR>", { desc = "Reload config" })

-- Easier binds to write and quit, work best when the CAPS key has been changed to send CTRL
vim.keymap.set({ "i", "n" }, "<C-s>", "<Esc><Cmd>w<CR>", { desc = "Save file" })
vim.keymap.set({ "i", "n" }, "<C-e>", "<Esc><Cmd>q<CR>", { desc = "Quit window" })

-- Sourcing the whole current file or a specific line. Very useful when experimenting with new config things
vim.keymap.set("n", "<space>x", ":.lua<CR>", { desc = "Source current Lua line" })
vim.keymap.set("v", "<space>x", ":lua<CR>", { desc = "Source selected Lua" })
vim.keymap.set("n", "<space>X", ":luafile %<CR>", { desc = "Source current Lua file" })

-- Quick way to access Netrw, the native file manager
-- vim.keymap.set("n", "<leader>-", ":Ex<CR>", { desc = "Open Netrw explorer" })

---- Resizing Splits
vim.keymap.set("n", "<C-.>", "<cmd>vertical resize +5<CR>", { desc = "Increase split width" })
vim.keymap.set("n", "<C-,>", "<cmd>vertical resize -5<CR>", { desc = "Decrease split width" })
vim.keymap.set("n", "<C-Up>", "<cmd>resize +3<CR>", { desc = "Increase split height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -3<CR>", { desc = "Decrease split height" })

---- Moving inbetween nvim windows, easier than the default
--- (This is commented because im using now the tmux-navigator plugin so it would interfere)
-- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })

---- Escaping the terminal mode with an easy bind.
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

---- Toggling Neotree
vim.keymap.set("n", "<leader>-", "<cmd>Neotree toggle<CR>", { desc = "Toggle Neotree side bar" })

--- TODO navigation
vim.keymap.set("n", "<leader>to", function()
  local cwd = vim.fn.expand("%:h")
  vim.cmd("TodoQuickFix cwd=" .. cwd)
end, { desc = "Open Todos in Quickfix List" })
-- The config for the working directory allows to be based on the current file, In the case that you moved to a different cwd than
-- the one you entered vim from. ':h' also moved that one level up, so it will show the todos for the current file's directory.
-- TODO: make this so that the comment string changes depending on the filetype
vim.keymap.set("n", "<leader>ta", "i# TODO: ", { desc = "Adding a TODO and staying in insert mode" })

---- Diagnostics confNig.
vim.diagnostic.config({
  virtual_text = {
    prefix = "▎",
  },
  virtual_text_ok = true,
  update_in_insert = false,
  signs = false,
})

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#fb4934", bg = "#3c1f1e" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#fabd2f", bg = "#3a2f1a" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#83a598", bg = "#1f3036" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#8ec07c", bg = "#24351f" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextOk", { fg = "#b8bb26", bg = "#2f3418" })

vim.keymap.set("n", "<leader>di", function()
  local diagnostics = vim.diagnostic.get(0)
  if #diagnostics == 0 then
    require("notify")("No diagnostics", "error", { title = "Diagnostics" })
    return
  end
  vim.diagnostic.setqflist({ open = true })
end, { desc = "Open diagnostics in loclist" })

--- Database work with Dadbod
vim.keymap.set("n", "<leader>db", "<cmd>DBUIToggle<CR>", { desc = "Toggle database UI" })

--- Resourcing Snippets file to play with new ones
vim.keymap.set(
  "n",
  "<leader>R",
  ":source ~/.config/nvim/lua/config/snippets.lua<CR>",
  { desc = "Reload snippets file" }
)

--- quickfix navigation
vim.keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix item" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })
vim.keymap.set("n", "<leader>qc", "<cmd>cclose<CR>", { desc = "Close quickfix list" })
vim.keymap.set("n", "<leader>qo", "<cmd>copen<CR>", { desc = "Open quickfix list" })

----

-- Highlight on yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlighting when yanking text",
  group = vim.api.nvim_create_augroup("highlighting-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- SNIPPETS
require("config.snippets")

-- Setting a specific highlighting color for a specific treesitter type.
-- Use ':Inspect' with the cursor on a word to see the highliting group,
-- or ':InspectTree' for an "interactive" overview.
vim.cmd([[hi @function.call.python guifg=yellow]])

-- enabling custom folding for large files:
-- Use expression-based folding
vim.opt.foldmethod = "marker"
vim.opt.foldmarker = "{{{,}}}"

-- -- Prevent code from auto-collapsing when opening a new buffer
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

require("config.molten_config")
