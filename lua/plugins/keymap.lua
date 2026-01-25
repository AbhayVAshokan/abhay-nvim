-- Keymap configuration for custom keybindings
---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      -- Normal mode mappings
      n = {
        -- Leader gp: Copy relative path of current buffer to clipboard
        ["<Leader>gu"] = {
          function()
            local path = vim.fn.expand "%"
            if path and path ~= "" then
              vim.fn.setreg("+", path)
              vim.notify("Copied relative path: " .. path, vim.log.levels.INFO)
            else
              vim.notify("No file path available", vim.log.levels.WARN)
            end
          end,
          desc = "Copy relative path",
        },

        -- Leader fl: Find the LSP references for the keyword.
        ["<leader>fl"] = {
          function() require("telescope.builtin").lsp_references() end,
          desc = "Find LSP references",
        },
        -- Leader f;: Find word under the cursor except inside the spec folder
        ["<leader>f;"] = {
          function()
            require("telescope.builtin").grep_string {
              additional_args = function() return { "--glob", "!spec/**" } end,
            }
          end,
          desc = "Find word under the cursor excpet inside the spec folder",
        },
        -- Leader zs: Replay the last callout in Zuora for my user id.
        ["<leader>zl"] = {
          function()
            vim.notify("Replaying your last callout in Zuora", vim.log.levels.INFO)
            vim.fn.jobstart("cd ~/Documents/work/zsim && PROMPT='replay_last' ./bin/zsim", {
              on_exit = function() vim.notify("Replayed your last callout in Zuora", vim.log.levels.INFO) end,
            })
          end,
          desc = "Replay your last callout in Zuora",
        },
        ["<leader>z1"] = {
          function()
            vim.notify("Replaying the callouts from 1 hour ago", vim.log.levels.INFO)
            vim.fn.jobstart("cd ~/Documents/work/zsim && PROMPT='replay_1' ./bin/zsim", {
              on_exit = function() vim.notify("Replayed the callouts for last 1 hour", vim.log.levels.INFO) end,
            })
          end,
          desc = "Replay callouts from the last 1 hour",
        },
      },
    },
  },
}
