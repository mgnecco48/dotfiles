return {
  "stevearc/conform.nvim",

  event = { "BufWritePre" },
  keys = {
    {
      "<leader>g",
      function()
        require("conform").format({
          async = true,
          timeout_ms = 3000,
          lsp_format = "fallback",
        })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },

  opts = {
    format_on_save = {
      timeout_ms = 3000,
      lsp_format = "fallback",
    },

    formatters_by_ft = {

      -- Python
      python = { "ruff_format" },

      -- Lua
      lua = { "stylua" },

      -- JSON
      json = { "prettier" },

      -- JSONC
      jsonc = { "prettier" },

      -- YAML
      yaml = { "yamlfmt" },

      -- Bash
      sh = { "shfmt" },

      -- Markdown
      markdown = { "prettier" },

      -- TOML
      toml = { "taplo" },

      -- SQL
      sql = { "pg_format" },

      -- Dockerfile
      dockerfile = { "dockerfmt" },

      java = { "google-java-format" },
    },
    formatters = {
      prettier = {
        prepend_args = {
          "--trailing-comma",
          "none",
        },
      },
    },
  },
}
