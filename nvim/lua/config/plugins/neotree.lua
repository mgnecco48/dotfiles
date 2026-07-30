return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false,                    -- neo-tree will lazily load itself
    opts = {
      close_if_last_window = true,   -- Close Neo-tree if it is the last window left in the tab
      popup_border_style = "",
      default_component_configs = {
        name = {
          use_git_status_colors = false,
        },
      },
    },
  },
}
