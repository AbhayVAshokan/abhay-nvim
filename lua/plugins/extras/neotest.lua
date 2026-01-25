return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "olimorris/neotest-rspec",
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("neotest").setup {
      adapters = {
        require "neotest-rspec" {
          rspec_cmd = function() return vim.split("bundle exec rspec", " ") end,
        },
      },
    }
  end,
}
