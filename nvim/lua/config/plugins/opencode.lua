return {
  {
    "nickjvandyke/opencode.nvim",
    -- version = "*", -- Latest stable release
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        "folke/snacks.nvim",
        opts = {
          input = { enabled = true }, -- Enhances `ask()`
          picker = { -- Enhances `select()`
            enabled = true,
            actions = {
              opencode_send = function(picker) ---@param picker snacks.Picker
                local items = vim.tbl_map(function(item) ---@param item snacks.picker.Item
                  return item.file
                      and require("opencode").format({ path = item.file, from = item.pos, to = item.end_pos })
                    or item.text
                end, picker:selected({ fallback = true }))

                require("opencode").prompt(table.concat(items, ", ") .. " ")
              end,
            },
            win = {
              input = {
                keys = {
                  ["<a-o>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any; goto definition on the type for details
      }

      -- Recommended/example keymaps
      vim.keymap.set({ "n", "x" }, "<leader>ask", function()
        require("opencode").ask("@this: ")
      end, { desc = "Ask OpenCode…" })
      vim.keymap.set({ "n", "x" }, "<C-x>", function()
        require("opencode").select()
      end, { desc = "Select OpenCode…" })
      vim.keymap.set({ "n", "x" }, "go", function()
        return require("opencode").operator("@this")
      end, { desc = "Send range to OpenCode", expr = true })
      vim.keymap.set({ "n" }, "goo", function()
        return require("opencode").operator("@this") .. "_"
      end, { desc = "Send line to OpenCode", expr = true })

      require("blink.cmp").setup({
        sources = {
          -- Either enable LSP (and optionally buffer) source globally
          default = { "lsp", "buffer" },
          -- Or only for Ask
          per_filetype = {
            opencode_ask = { "lsp", "buffer" },
          },
          -- Display buffer completions (if included above) when no LSP completions are available
          providers = { lsp = { fallbacks = {} } },
        },
      })
    end,
  },
}
