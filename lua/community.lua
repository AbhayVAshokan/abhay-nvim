-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- language improvements
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.vue" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.eslint" },
  { import = "astrocommunity.pack.prettier" },
  { import = "astrocommunity.pack.tailwindcss" },

  -- ui improvements
  { import = "astrocommunity.bars-and-lines.dropbar-nvim" },
  { import = "astrocommunity.motion.marks-nvim" },

  -- tooling improvements
  { import = "astrocommunity.fuzzy-finder.telescope-nvim" },
  { import = "astrocommunity.git.git-blame-nvim" },
  { import = "astrocommunity.git.diffview-nvim" },
  -- { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },

  -- motion
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.editing-support.nvim-treesitter-endwise" },

  -- scroll
  { import = "astrocommunity.scrolling.nvim-scrollbar" },
  { import = "astrocommunity.scrolling.satellite-nvim" },

  -- test
  { import = "astrocommunity.test.neotest" },
}
