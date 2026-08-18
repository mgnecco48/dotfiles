return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    keywords = {
      ASK = { icon = "?", color = "#ff83fa", alt = { "QUESTION" } },
      TODO = { icon = " ", color = "#00e5ee" },
    },
  },
}
