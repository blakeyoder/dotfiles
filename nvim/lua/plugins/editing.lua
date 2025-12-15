-- Editing enhancements

return {
  -- Surround (same as vim-surround but Lua)
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- Comments (replaces nerdcommenter)
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Auto-close and rename HTML/JSX tags
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Better repeat with .
  {
    "tpope/vim-repeat",
  },

  -- Handy bracket mappings
  {
    "tpope/vim-unimpaired",
  },

  -- Emmet for HTML/CSS
  {
    "mattn/emmet-vim",
  },

  -- Auto-detect indent
  {
    "tpope/vim-sleuth",
  },

  -- Tabular alignment
  {
    "godlygeek/tabular",
  },
}
