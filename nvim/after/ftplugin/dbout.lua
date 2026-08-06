vim.opt_local.foldenable = false
vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.signcolumn = "no"
vim.opt_local.wrap = false
vim.opt_local.spell = false
vim.opt_local.list = false

vim.api.nvim_set_hl(0, "DBout", { bg = "#2f4f4f", fg = "#f5f5f5" })
vim.api.nvim_set_hl(0, "DBoutCursorLine", { bg = "#7a8b8b", fg = "#f5f5f5" })

vim.wo.winhighlight = "Normal:DBout,CursorLine:DBoutCursorLine"
