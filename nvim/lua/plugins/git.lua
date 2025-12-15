-- Git integration

return {
  -- Fugitive (keeping this - still the best for Git commands)
  {
    "tpope/vim-fugitive",
  },

  -- GitHub integration
  {
    "tpope/vim-rhubarb",
  },

  -- Gitsigns (replaces vim-gitgutter - faster, more features)
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        current_line_blame = false, -- Toggle with :Gitsigns toggle_current_line_blame
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
          end, { expr = true, desc = "Next hunk" })

          map("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
          end, { expr = true, desc = "Previous hunk" })

          -- Actions
          map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
          map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
          map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
          map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
          map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
          map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
          map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
          map("n", "<leader>gB", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
          map("n", "<leader>gd", gs.diffthis, { desc = "Diff this" })
        end,
      })
    end,
  },

  -- Git log viewer
  {
    "junegunn/gv.vim",
    dependencies = { "tpope/vim-fugitive" },
  },
}
