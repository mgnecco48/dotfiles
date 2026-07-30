return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",

  dependencies = {
    "mason-org/mason.nvim",
  },

  opts = {
    ensure_installed = {

      -- formatters
      "black",
      "isort",
      "stylua",
      "shfmt",
      "ruff",
      "jq",
      "yamlfmt",
      "prettier",
      "goimports",
      "google-java-format",
      "pgformatter",
      "dockerfmt",

      -- linters
      "shellcheck",
      "sqlfluff",
      "golangci-lint",
    },

    auto_update = false,
    run_on_start = true,
  },
}
