--- New plugins not part of the Astro nvim ecosystem
---@type LazySpec
return {
  -- Add keybinding to close the terminal.
  -- FIXME: currently, the toggleterm does not close with the C-j combination.
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<C-j>", "<cmd>ToggleTerm<CR>", mode = { "n", "i", "v" }, desc = "Toggle terminal" },
      { "<C-j>", "<C-\\><C-n>:ToggleTerm<CR>", mode = "t", desc = "Close terminal" },
    },
  },

  -- Move the neotree position to the right, show hidden folders.
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
      window = {
        position = "right",
      },
    },
  },
  { "tpope/vim-rails" },

  -- gitlab-lsp is an alternative for the official gitlab duo plugin
  -- built by Aboobacker MK
  {
    "https://gitlab.com/abhayvashokan/gitlab-lsp.git",
    branch = "reduce-interruptions",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitlab-lsp").setup {
        -- Optional: override default settings
        gitlab_url = "https://gitlab.com", -- or your self-hosted instance
        filetypes = { "ruby", "go", "javascript", "typescript", "rust", "lua", "python" },
        log_level = "info", -- 'debug', 'info', 'warn', 'error'
      }

      -- Inline completion keymaps
      local function setup_inline_completion_keymaps(bufnr)
        -- Navigate through suggestions
        vim.keymap.set("i", "<M-[>", vim.lsp.inline_completion.select_prev, { buffer = bufnr })
        vim.keymap.set("i", "<M-]>", vim.lsp.inline_completion.select_next, { buffer = bufnr })

        -- Accept completion
        vim.keymap.set("i", "<M-y>", vim.lsp.inline_completion.accept, { buffer = bufnr })

        -- Trigger completion manually
        vim.keymap.set("i", "<M-\\>", vim.lsp.inline_completion.trigger, { buffer = bufnr })

        -- Dismiss completion
        vim.keymap.set("i", "<M-e>", vim.lsp.inline_completion.hide, { buffer = bufnr })
      end

      -- Set up keymaps when LSP attaches to a buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "gitlab-lsp" then setup_inline_completion_keymaps(args.buf) end
        end,
      })

      -- Your existing keymap
      vim.keymap.set("i", "<C-CR>", function()
        if not vim.lsp.inline_completion.get() then return "<C-CR>" end
      end, {
        expr = true,
        replace_keycodes = true,
        desc = "Get the current inline completion",
      })
    end,
  },

  -- get permalinks to the selected file/code.
  {
    "ruifm/gitlinker.nvim",
    config = function()
      local gl = require "gitlinker"
      gl.setup {
        mappings = nil,
      }
      vim.keymap.set(
        "n",
        "<leader>gy",
        [[<Cmd>lua require"gitlinker".get_buf_range_url("n")<CR>]],
        { silent = true, desc = "Copy Line URL" }
      )
      vim.keymap.set(
        "v",
        "<leader>gY",
        [[<Cmd>lua require"gitlinker".get_buf_range_url("v")<CR>]],
        { desc = "Copy Block URL" }
      )
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- automatically insert next item in bullet/numbered lists in markdown.
  {
    "dkarter/bullets.vim",
    ft = { "markdown", "text" },
    config = function() vim.g["bullets_set_mappings"] = 0 end,
  },

  -- Disable Volar formatting for Vue files
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      local astrocore = require "astrocore"
      return astrocore.extend_tbl(opts, {
        config = {
          volar = {
            on_attach = function(client)
              -- Disable Volar's formatting capabilities
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentRangeFormattingProvider = false
            end,
          },
        },
      })
    end,
  },

  -- Make kebab case component usages recognizable.
  {
    "AstroNvim/astrolsp",
    opts = {
      config = {
        volar = {
          settings = {
            vue = {
              complete = {
                casing = {
                  tags = "autoKebab",
                  props = "autoKebab",
                },
              },
            },
          },
          init_options = {
            vue = {
              hybridMode = true,
            },
          },
        },
      },
    },
  },
}

-- TODO: check if any of these are present in community.
-- TODO: "jake-stewart/multicursor.nvim": multiple cursors like vscode.
