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
map("n", "<leader>4", "$", { desc = "End of line" })
map("n", "<leader>9", "(", { desc = "Previous sentence" })

-- Buffer management
map("n", "<leader>T", ":enew<CR>", { desc = "New buffer" })
map("n", "<leader>]", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>[", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bl", ":ls<CR>", { desc = "List buffers" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Close buffer" })

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

-- Python debug shortcuts
map("n", "<leader>p", "oimport pdb; pdb.set_trace()<Esc>:w<CR>", { desc = "Insert pdb" })
map("n", "<leader>r", "ofrom remote_pdb import set_trace; set_trace()<Esc>:w<CR>", { desc = "Insert remote_pdb" })

-- Quick access to common project files
map("n", "<leader>ep", ":e package.json<CR>", { desc = "Edit package.json" })
map("n", "<leader>ea", ":e app.json<CR>", { desc = "Edit app.json" })
map("n", "<leader>ec", ":e app.config.js<CR>", { desc = "Edit app.config.js" })
map("n", "<leader>ee", ":e eas.json<CR>", { desc = "Edit eas.json" })
map("n", "<leader>et", ":e tsconfig.json<CR>", { desc = "Edit tsconfig.json" })
