vim.opt_local.wrap = true -- Display long Markdown lines on multiple screen lines.
vim.opt_local.linebreak = true -- Prefer wrapping at word boundaries instead of in the middle of words.
vim.opt_local.breakindent = true -- Indent visually wrapped lines to match the start of the original line.
vim.opt_local.breakindentopt = "list:-1,sbr" -- Align wrapped lines after list markers, with showbreak before the indent.
vim.opt_local.formatoptions:remove({ "t", "a" }) -- Disable automatic hard-wrapping while typing.
vim.opt_local.spell = true -- Enable spell checking for Markdown buffers.
vim.opt_local.scrolloff = 999 -- Keep the cursor vertically centered while scrolling.
vim.opt_local.showbreak = "↪" -- Mark visually wrapped lines without changing the file contents.
vim.opt_local.spelllang = { "en", "es" }
------------------------
---NOTEBOOK SPECIFIC ---
------------------------

require("quarto").activate()

vim.keymap.set("n", "<S-CR>", function()
  require("quarto.runner").run_cell()
  require("nvim-treesitter-textobjects.move").goto_next_start("@code_cell.inner", "textobjects")
end, { buffer = true, desc = "Run cell and move to next" })

local notebook_extensions = {
  ipynb = true,
  qmd = true,
}

if notebook_extensions[vim.fn.expand("%:e")] then
  local buf = vim.api.nvim_get_current_buf()
  local ns = vim.api.nvim_create_namespace("notebook_cell_separators")

  local function refresh_cell_separators()
    if not vim.api.nvim_buf_is_valid(buf) then
      return
    end

    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

    local separator = string.rep("━", vim.bo[buf].textwidth)
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

    local in_code_cell = false
    for i, line in ipairs(lines) do
      if line:match("^```%s*[%w_{]") then
        in_code_cell = true
        vim.api.nvim_buf_set_extmark(buf, ns, i - 1, 0, {
          virt_lines = {
            { { separator, "Comment" } },
          },
          virt_lines_above = true,
        })
      elseif in_code_cell and line:match("^```%s*$") then
        in_code_cell = false
        local separator_line = math.min(i, #lines - 1)
        vim.api.nvim_buf_set_extmark(buf, ns, separator_line, 0, {
          virt_lines = {
            { { separator, "Comment" } },
          },
          virt_lines_above = true,
        })
      end
    end
  end

  refresh_cell_separators()

  local group = vim.api.nvim_create_augroup("markdown_notebook_cell_separators", { clear = false })
  vim.api.nvim_clear_autocmds({ group = group, buffer = buf })
  vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI", "WinResized" }, {
    group = group,
    buffer = buf,
    callback = refresh_cell_separators,
  })
end
