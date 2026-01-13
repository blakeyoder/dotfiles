-- Options

local opt = vim.opt

-- File handling and undo
opt.autoread = true
opt.history = 200
opt.swapfile = false
opt.writebackup = false
opt.undofile = true
opt.undolevels = 1000

-- Create undodir if it doesn't exist
local undodir = vim.fn.stdpath("data") .. "/undo"
opt.undodir = undodir
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p", tonumber("0700", 8))
end

-- Clipboard
opt.clipboard = "unnamed"

-- UI
opt.cursorline = true
opt.synmaxcol = 500
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.showmode = false
opt.laststatus = 2
opt.belloff = "all"
opt.fillchars = { vert = " ", stl = " ", stlnc = " " }
opt.signcolumn = "yes"

-- Buffers
opt.updatetime = 250

-- Security
opt.modelines = 0

-- Whitespace
opt.wrap = true
opt.formatoptions = "tcqrn1"
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.shiftround = false

-- Cursor motion
opt.scrolloff = 3
opt.matchpairs:append("<:>")

-- Searching
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true

-- Mouse (disabled)
opt.mouse = ""

-- Path for imports
opt.path:append("src/**")
opt.suffixesadd:append(".ts,.tsx,.js,.jsx")
