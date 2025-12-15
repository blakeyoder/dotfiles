-- Telescope: Fuzzy finder for everything
-- Replaces fzf.vim with a more powerful, extensible solution

return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Native FZF sorter for better performance
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          -- Layout
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              preview_width = 0.55,
              prompt_position = "top",
            },
            width = 0.87,
            height = 0.80,
          },
          sorting_strategy = "ascending",

          -- Mappings inside Telescope
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<Esc>"] = actions.close,
            },
          },

          -- Ignore patterns (similar to your fzf setup)
          file_ignore_patterns = {
            "node_modules",
            ".git/",
            "ios/Pods",
            "android/.gradle",
            "%.lock",
          },
        },

        pickers = {
          find_files = {
            hidden = true,
          },
          live_grep = {
            additional_args = function()
              return { "--hidden" }
            end,
          },
        },
      })

      -- Load FZF extension for better sorting
      telescope.load_extension("fzf")

      -- Keymaps (replacing your fzf mappings)
      vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Find git files" })
      vim.keymap.set("n", "<C-f>", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find all files" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
      vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find recent files" })
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find word under cursor" })
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find diagnostics" })
      vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume last search" })

      -- LSP integration
      vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find symbols" })
      vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, { desc = "Find workspace symbols" })
    end,
  },
}
