-- Keymaps

local map = vim.keymap.set

-- Show keybinding help
map("n", "<leader>?", ":WhichKey<CR>", { desc = "Show all keybindings" })

-- Window navigation with Ctrl + hjkl
map("n", "<C-J>", "<C-W><C-J>", { desc = "Move to window below" })
map("n", "<C-K>", "<C-W><C-K>", { desc = "Move to window above" })
map("n", "<C-L>", "<C-W><C-L>", { desc = "Move to window right" })
map("n", "<C-H>", "<C-W><C-H>", { desc = "Move to window left" })

-- Select all
map("n", "<leader>a", "ggVG", { desc = "Select all" })

-- Copy all
map("n", "<leader>y", "ggVGy", { desc = "Copy all" })

-- Quick movement shortcuts
map("n", "<leader>0", "$", { desc = "End of line" })
map("n", "<leader>9", "(", { desc = "Previous sentence" })

-- Buffer management
map("n", "<leader>T", ":enew<CR>", { desc = "New buffer" })
map("n", "<S-l>", ":BufferLineCycleNext<CR>", { desc = "Next buffer", silent = true })
map("n", "<S-h>", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer", silent = true })
map("n", "<leader>]", ":BufferLineCycleNext<CR>", { desc = "Next buffer", silent = true })
map("n", "<leader>[", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer", silent = true })
map("n", "<leader>bl", ":ls<CR>", { desc = "List buffers" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Close buffer" })
map("n", "<leader>bp", ":BufferLineTogglePin<CR>", { desc = "Pin buffer", silent = true })
map("n", "<leader>bo", ":BufferLineCloseOthers<CR>", { desc = "Close other buffers", silent = true })

-- Map jj to escape
map("i", "jj", "<ESC>", { desc = "Escape" })

-- Quick save
map("n", "<leader>w", ":w<CR>", { desc = "Save" })

-- Quick quit
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Quick source config
map("n", "<leader>sv", ":source $MYVIMRC<CR>", { desc = "Source config" })

-- Clear search highlighting
map("n", "<leader><space>", ":let @/=''<CR>", { desc = "Clear search" })

-- Very magic search
map("n", "/", "/\\v", { desc = "Search with very magic" })
map("v", "/", "/\\v", { desc = "Search with very magic" })

-- Disable recording (q mapped to nothing)
map("n", "q", "<Nop>", { desc = "Disable recording" })
