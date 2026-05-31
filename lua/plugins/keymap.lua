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
        ["<leader>fd"] = {
          function()
            local word = vim.fn.expand "<cword>"
            local patterns = { "def " .. word, "def self\\." .. word }
            local results = {}
            for _, pattern in ipairs(patterns) do
              local lines = vim.fn.systemlist("rg --vimgrep " .. vim.fn.shellescape(pattern) .. " .")
              if #lines > 0 then
                results = lines
                break
              end
            end
            if #results == 0 then
              vim.notify("No definition found for: " .. word, vim.log.levels.WARN)
              return
            end
            if #results == 1 then
              local file, lnum, col = results[1]:match "^(.-):(%d+):(%d+):"
              if file then
                vim.cmd("edit " .. vim.fn.fnameescape(file))
                vim.api.nvim_win_set_cursor(0, { tonumber(lnum), tonumber(col) - 1 })
              end
              return
            end
            local qf_items = {}
            for _, line in ipairs(results) do
              local file, lnum, col, text = line:match "^(.-):(%d+):(%d+):(.*)"
              if file then
                table.insert(qf_items, {
                  filename = file,
                  lnum = tonumber(lnum),
                  col = tonumber(col),
                  text = text,
                })
              end
            end
            vim.fn.setqflist(qf_items, "r")
            require("telescope.builtin").quickfix()
          end,
          desc = "Find Ruby method definition",
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

