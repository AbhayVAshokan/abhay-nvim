return {
  -- Configure Volar for Vue files
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
    })
  end,
}
