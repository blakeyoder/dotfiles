-- UI plugins (statusline, file tree, buffers)

return {
  -- Statusline (replaces vim-airline)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- Buffer line (replaces airline tabline)
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Get gruvbox colors
      local colors = {
        bg = "#282828",
        bg1 = "#3c3836",
        bg2 = "#504945",
        fg = "#ebdbb2",
        yellow = "#d79921",
        green = "#98971a",
        blue = "#458588",
        aqua = "#689d6a",
        red = "#cc241d",
        orange = "#d65d0e",
        gray = "#928374",
      }

      require("bufferline").setup({
        options = {
          mode = "buffers",
          diagnostics = "nvim_lsp",
          show_buffer_close_icons = false,
          show_close_icon = false,
          separator_style = "thin",
        },
        highlights = {
          fill = { bg = colors.bg },
          background = { bg = colors.bg1, fg = colors.gray },
          buffer_selected = { bg = colors.bg, fg = colors.fg, bold = true },
          buffer_visible = { bg = colors.bg1, fg = colors.gray },
          separator = { bg = colors.bg1, fg = colors.bg },
          separator_selected = { bg = colors.bg, fg = colors.bg },
          separator_visible = { bg = colors.bg1, fg = colors.bg },
          tab = { bg = colors.bg1, fg = colors.gray },
          tab_selected = { bg = colors.bg, fg = colors.fg },
          tab_close = { bg = colors.bg1, fg = colors.red },
        },
      })
    end,
  },

  -- File tree (replaces NERDTree)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 28,
        },
        filters = {
          custom = { ".pyc$", "__pycache__", ".git" },
        },
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
      })
      -- Keymaps (same as your NERDTree mappings)
      vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
      vim.keymap.set("n", "<C-m>", ":NvimTreeFindFile<CR>", { desc = "Find file in tree" })
    end,
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
      require("nvim-web-devicons").setup()
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = { char = "│" },
        scope = { enabled = false },
      })
    end,
  },
}
