return {
  {
    "neovim/nvim-lspconfig",

    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "⏳",
              package_uninstalled = "✗",
            },
          },
        },
      },
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      { -- optional blink completion source for require statements and module annotations
        "saghen/blink.cmp",
        opts = {
          sources = {
            -- add lazydev to your completion providers
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
              lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                -- make lazydev completions top priority (see `:h blink.cmp`)
                score_offset = 100,
              },
            },
          },
        },
      },

      { "j-hui/fidget.nvim", opts = {} },
    },

    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      --- adding blink capabilities to  all servers.
      vim.lsp.config["*"] = {
        capabilities = capabilities,
      }
      --- Special configd for certain servers
      --- Python, mainly for the jupyter notebooks to work
      local function python_path()
        if vim.env.CONDA_PREFIX then
          return vim.env.CONDA_PREFIX .. "/bin/python"
        end

        if vim.env.VIRTUAL_ENV then
          return vim.env.VIRTUAL_ENV .. "/bin/python"
        end

        return vim.fn.exepath("python3") or vim.fn.exepath("python")
      end

      vim.lsp.config["pyright"] = {
        settings = {
          python = {
            pythonPath = python_path(),
          },
        },
      }

      --- Special Lua Config recommended by Neovim
      vim.lsp.config["lua_ls"] = {
        cmd = { "lua-language-server" },

        filetypes = { "lua" },

        capabilities = capabilities,

        root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },

        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                vim.api.nvim_get_runtime_file("", true),
              },
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },

            completion = {
              callSnippet = "Replace",
            },
          },
        },
      }

      -- Postgres fixes
      vim.lsp.config["postgres_lsp"] = {
        workspace_required = false,
      }

      -- -- enabling lsp servers
      -- Usually would run somethin like 'vim.lsp.enable("lua_ls")', but since we have the mason-lspconfig plugin, that is taken care of for us.

      -- configuring "Autocommands"
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("my.lsp", { clear = true }),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          local bufnr = args.buf

          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, {
              buffer = bufnr,
              desc = desc,
            })
          end

          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "gr", vim.lsp.buf.references, "Go to references")
          map("n", "gI", vim.lsp.buf.implementation, "Go to implementation")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "K", vim.lsp.buf.hover, "Hover documentation")

          if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
        end,
      })
    end,
  },
}
