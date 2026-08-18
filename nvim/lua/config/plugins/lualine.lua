return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local colors = {
      blue = "#80a0ff",
      cyan = "#00e5ee",
      black = "#080808",
      white = "#ffffff",
      red = "#cd0000",
      yellow = "#ffd700",
      violet = "#d183e8",
      grey = "#525252",
      green = "#00cd00",
      sage = "#43cd80",
    }

    local bubbles_theme = {
      normal = {
        a = { fg = colors.black, bg = colors.violet },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.white, bg = "NONE" },
      },
      insert = { a = { fg = colors.black, bg = colors.yellow } },
      visual = { a = { fg = colors.black, bg = colors.cyan } },
      replace = { a = { fg = colors.black, bg = colors.red } },
      inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.white },
      },
      terminal = {
        a = { fg = colors.black, bg = colors.green },
        b = { fg = colors.white, bg = colors.grey },
      },
      command = {
        a = { fg = colors.black, bg = colors.sage },
      },
    }

    local lsp = {
      "lsp_status",
      color = { gui = "italic", fg = colors.violet },
      icon = " ",
      symbols = {
        -- Standard unicode symbols to cycle through for LSP progress:
        spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
        -- Standard unicode symbol for when LSP is done:
        done = "✓",
        -- Delimiter inserted between LSP names:
        separator = ", ",
      },
      ignore_lsp = { "GitHub Copilot" },
    }

    local diff = {
      "diff",
      symbols = { added = " ", modified = " ", removed = " " },
      diff_color = {
        added = { fg = colors.green },
        removed = { fg = colors.red },
        modified = { fg = colors.yellow },
      },
    }

    local filename = {
      "filename",
      color = { gui = "italic,bold" },
      file_status = false,
    }

    require("lualine").setup({
      options = {
        globalstatus = true,
        theme = bubbles_theme,
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
        lualine_b = { filename, "branch" },
        lualine_c = { diff, "%=" },
        lualine_x = { lsp },
        lualine_y = { "filetype", "progress" },
        lualine_z = {
          { "location", separator = { right = "" }, left_padding = 2 },
        },
      },

      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
      tabline = {},
      extensions = {},
    })
  end,
}
