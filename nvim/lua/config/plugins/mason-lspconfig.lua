return {
  {
    "mason-org/mason-lspconfig.nvim",

    opts = {
      automatic_enable = {
        exclude = { "jdtls", "sqlls" },
      },
      ensure_installed = {
        "pyright",
        "lua_ls",
        "dockerls",
        "sqlls",
        "jsonls",
        "yamlls",
        "bashls",
        "marksman",
        "taplo",
        "hyprls",
        "vimls",
        "gopls",
        "jdtls",
        "vtsls",
        "tailwindcss",
        "postgres_lsp",
        "html",
        "cssls",
      },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
}
