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
      },
    },
  },
}
