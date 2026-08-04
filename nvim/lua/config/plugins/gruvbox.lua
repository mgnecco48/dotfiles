return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      local colors = {
        electric_cyan = "#00e5ee",
        bright_white = "#ffffff",
        electric_purple = "#ff83fa",
        baby_blue = "#b0e0e6",
        sage = "#43cd80",
      }

      local frame_ui = colors.electric_cyan

      require("gruvbox").setup({
        overrides = {
          Pmenu = { bg = "none" },
          PmenuKind = { bg = "none" },
          PmenuExtra = { bg = "none" },
          BlinkCmpScrollBarThumb = { bg = "#ffbf00" },
          BlinkCmpMenuSelection = { bg = "#665c54", fg = "#44eb44" },
          StatusLine = { bg = "none" },
          StatusLineNC = { bg = "none" },
          FloatBorder = { fg = frame_ui },
          TelescopeTitle = { fg = frame_ui },
          TelescopePromptBorder = { fg = frame_ui },
          TelescopeResultsBorder = { fg = frame_ui },
          TelescopePreviewBorder = { fg = frame_ui },
          WinSeparator = { bg = "none", fg = frame_ui },
          NeoTreeDirectoryIcon = { fg = frame_ui },
          NeoTreeDirectoryName = { fg = frame_ui },
          NeoTreeRootName = { fg = frame_ui, bold = true },
          NeoTreeFloatBorder = { fg = frame_ui },
          NeotreeFloatTitle = { fg = "#ffffff", italic = true, bold = true },
          NeoTreeGitAdded = { fg = "#44eb44" },
          NeoTreeGitConflict = { fg = "#ffbf00" },
          NeoTreeGitDeleted = { fg = "#fb4934" },
          NeoTreeGitModified = { fg = "#ee0000" },
          NeoTreeFilteredItem = { fg = frame_ui },

          -- RenderMarkdown heading placeholders.
          RenderMarkdownH1 = { fg = frame_ui, bold = true, underdotted = true, bg = "none" },
          RenderMarkdownH1Bg = { bg = "none", fg = colors.bright_white, bold = true, underdotted = true },
          RenderMarkdownH2 = { fg = frame_ui, bold = true, underdotted = true, bg = "none" },
          RenderMarkdownH2Bg = { bg = "none", fg = colors.bright_white, bold = true, underdotted = true },
          RenderMarkdownH3 = { fg = frame_ui, bold = true, underdotted = true, bg = "none" },
          RenderMarkdownH3Bg = { bg = "none", fg = colors.bright_white, bold = true, underdotted = true },
          RenderMarkdownH4 = { fg = frame_ui, bold = true, underdotted = true, bg = "none" },
          RenderMarkdownH4Bg = { bg = "none", fg = colors.bright_white, bold = true, underdotted = true },
          RenderMarkdownH5 = { fg = frame_ui, bold = true, underdotted = true, bg = "none" },
          RenderMarkdownH5Bg = { bg = "none", fg = colors.bright_white, bold = true, underdotted = true },
          RenderMarkdownH6 = { fg = frame_ui, bold = true, underdotted = true, bg = "none" },
          RenderMarkdownH6Bg = { bg = "none", fg = colors.bright_white, bold = true, underdotted = true },

          -- BlinkDocSeparator = { fg = "#44eb44" },
        },
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },
}
