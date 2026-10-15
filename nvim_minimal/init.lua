vim.g.mapleader = " "
vim.g.have_nerd_font = true
vim.opt.termguicolors = true
vim.o.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.wrap = false
vim.g.netrw_banner = 1
vim.o.scrolloff = 10
vim.opt.fillchars = {eob = " "}
vim.opt.cursorline = true


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
	vim.opt.clipboard = "unnamedplus"
end


-- Highlight on yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlighting when yanking text",
  group = vim.api.nvim_create_augroup("highlighting-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
vim.api.nvim_set_hl(0, "SignColumn", {bg = "none"})

vim.keymap.set({"i", "n"},  "<C-s>", "<Esc><Cmd>w<CR>")
vim.keymap.set({"i", "n"},  "<C-e>", "<Esc><Cmd>q<CR>")
vim.keymap.set("n", "<leader>-", "<Cmd>Ex<CR>")

vim.pack.add({
	{src = 'https://github.com/nvim-mini/mini.nvim',
	name = 'mini'},
	{src = 'https://github.com/nvim-treesitter/nvim-treesitter',
	name = 'treesitter'}
})
require("mini.icons").setup() -- use default config
require("mini.surround").setup()
-- Add/delete/replace surroundings (brackets, quotes, etc.)
-- Examples:
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']

require("mini.indentscope").setup({
	symbol = "▏",
	options = { try_as_border = true },
})
require("mini.pairs").setup({
	modes = { insert = true, command = true, terminal = false },
	skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
	skip_ts = { "string" },
	skip_unbalanced = true,
 	markdown = true,
 })
require("mini.ai").setup()
require('mini.statusline').setup()

vim.api.nvim_create_autocmd('PackChanged', {
  desc = 'Auto-update Treesitter parsers on plugin update',
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then
        vim.cmd('TSUpdate')
      end
    end
  end,
})

