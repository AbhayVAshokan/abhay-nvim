return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "ruby" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "ruby-lsp" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "ruby-lsp" })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = { "suketa/nvim-dap-ruby", config = true },
  },

  -- Configure none-ls to use bundled RuboCop
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      -- Remove all Ruby/RuboCop sources from none-ls
      opts.sources = vim.tbl_filter(function(source)
        -- Filter out any source related to Ruby or RuboCop
        if source.name and (source.name:match "ruby" or source.name:match "rubocop") then return false end
        if source.filetypes and vim.tbl_contains(source.filetypes, "ruby") then return false end
        return true
      end, opts.sources)
    end,
  },

  -- Also configure Conform to use bundled RuboCop
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ruby = { "rubocop" },
      },
      formatters = {
        rubocop = {
          command = "bundle",
          args = {
            "exec",
            "rubocop",
            "--auto-correct-all",
            "--stderr",
            "--force-exclusion",
            "--stdin",
            "$FILENAME",
            "-o",
            "/dev/null",
          },
        },
      },
    },
  },
}
