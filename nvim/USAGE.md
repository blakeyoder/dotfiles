# Blake's Neovim Setup - Usage Guide

Quick reference for keybindings and workflows. Leader key is `<Space>`.

---

## File Navigation

### Telescope (Fuzzy Finding)
| Key | Action |
|-----|--------|
| `<C-p>` | Find git files (fastest for git repos) |
| `<leader>ff` | Find all files (including untracked) |
| `<leader>fo` | Recent files |
| `<leader>fb` | Open buffers |
| `<leader>fh` | Help tags |
| `<leader>fw` | Search word under cursor |
| `<leader>fr` | Resume last search |
| `<C-f>` | Live grep (search file contents) |

**Inside Telescope:**
- `<C-j>/<C-k>` - Navigate results
- `<CR>` - Open file
- `<Esc>` - Close
- `<C-q>` - Send to quickfix list

### Neo-tree (File Tree)
| Key | Action |
|-----|--------|
| `<C-n>` | Toggle file tree |
| `<C-m>` | Reveal current file in tree |
| `H` | Toggle hidden/dotfiles (inside tree) |

### Harpoon (Quick File Switching)
Mark your most-used files and jump instantly. Better than buffers for core files.

| Key | Action |
|-----|--------|
| `<leader>ha` | Add current file to harpoon |
| `<leader>hh` | Open harpoon menu |
| `<leader>1` | Jump to harpoon file 1 |
| `<leader>2` | Jump to harpoon file 2 |
| `<leader>3` | Jump to harpoon file 3 |
| `<leader>4` | Jump to harpoon file 4 |
| `<leader>hn` | Next harpoon file |
| `<leader>hp` | Previous harpoon file |

**Power tip:** Harpoon your main files (e.g., component, test, types, styles) and use `<leader>1-4` to instantly switch.

---

## Code Navigation & LSP

### Go To
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `gi` | Go to implementation |
| `gt` | Go to type definition |
| `K` | Show hover documentation |

### Actions
| Key | Action |
|-----|--------|
| `<leader>ca` | Code actions (quick fixes, refactors) |
| `<leader>rn` | Rename symbol |
| `<leader>f` | Format file |
| `<leader>d` | Show diagnostic popup |
| `[d` / `]d` | Previous/next diagnostic |

### Symbols (Telescope)
| Key | Action |
|-----|--------|
| `<leader>fs` | Document symbols |
| `<leader>fS` | Workspace symbols |
| `<leader>fd` | All diagnostics |

---

## Trouble (Diagnostics Panel)

Better than the quickfix list for viewing errors/warnings.

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle all diagnostics |
| `<leader>xX` | Buffer diagnostics only |
| `<leader>xs` | Document symbols |
| `<leader>xl` | LSP definitions/references |
| `<leader>xQ` | Quickfix list |

---

## Git

### Gitsigns (Hunks)
| Key | Action |
|-----|--------|
| `]c` / `[c` | Next/previous hunk |
| `<leader>gs` | Stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gS` | Stage entire buffer |
| `<leader>gu` | Undo stage hunk |
| `<leader>gp` | Preview hunk |
| `<leader>gb` | Blame line (full) |
| `<leader>gB` | Toggle line blame |
| `<leader>gd` | Diff this file |

### Fugitive Commands
| Command | Action |
|---------|--------|
| `:G` | Git status (interactive) |
| `:G blame` | Full file blame |
| `:G log` | Git log |
| `:GV` | Visual git log (gv.vim) |
| `:GBrowse` | Open file on GitHub |

---

## Motion & Editing

### Flash (Quick Jump)
| Key | Action |
|-----|--------|
| `s` | Flash jump (type chars, then label) |
| `S` | Flash treesitter (select syntax nodes) |
| `f/F/t/T` | Enhanced with labels for multiple matches |

**Power tip:** Press `s`, type 2 chars of your target, then press the label to jump instantly.

### Surround
| Key | Action |
|-----|--------|
| `ys{motion}{char}` | Add surround (e.g., `ysiw"` adds quotes around word) |
| `ds{char}` | Delete surround (e.g., `ds"` removes quotes) |
| `cs{old}{new}` | Change surround (e.g., `cs"'` changes " to ') |

### Comments
| Key | Action |
|-----|--------|
| `gcc` | Toggle comment (line) |
| `gc{motion}` | Toggle comment (motion) |
| `gbc` | Toggle block comment |

### Text Objects (mini.ai)
Enhanced text objects that work with treesitter:

| Object | Description |
|--------|-------------|
| `af/if` | Function (outer/inner) |
| `ac/ic` | Class |
| `al/il` | Loop |
| `ao/io` | Conditional |
| `aa/ia` | Parameter/argument |
| `a//i/` | Comment |

**Example:** `daf` deletes entire function, `cif` changes function body.

### Move Lines (mini.move)
| Key | Action |
|-----|--------|
| `<M-j>` | Move line/selection down |
| `<M-k>` | Move line/selection up |
| `<M-h>` | Move line/selection left |
| `<M-l>` | Move line/selection right |

---

## Buffers & Windows

### Buffer Navigation
| Key | Action |
|-----|--------|
| `<leader>l` or `<leader>]` | Next buffer |
| `<leader>[` | Previous buffer |
| `<leader>bd` | Close buffer |
| `<leader>bl` | List buffers |
| `<leader>T` | New buffer |

### Window Navigation
| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move between windows |

---

## Quick Actions

| Key | Action |
|-----|--------|
| `<leader>w` | Save |
| `<leader>q` | Quit |
| `<leader>a` | Select all |
| `<leader>y` | Copy all |
| `<leader><space>` | Clear search highlight |
| `<leader>sv` | Reload config |
| `<leader>?` | Show all keybindings (which-key) |
| `jj` | Escape (insert mode) |

### Project Files
| Key | Action |
|-----|--------|
| `<leader>ep` | Edit package.json |
| `<leader>et` | Edit tsconfig.json |
| `<leader>ea` | Edit app.json |
| `<leader>ec` | Edit app.config.js |
| `<leader>ee` | Edit eas.json |

---

## Completion

In insert mode:
| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion |
| `<Tab>` | Next completion / expand snippet |
| `<S-Tab>` | Previous completion |
| `<CR>` | Confirm selection |
| `<C-e>` | Close completion |
| `<C-b>/<C-f>` | Scroll docs |

---

## Power User Workflows

### 1. Navigating a New Codebase
```
<C-f>           → Search for keywords in all files
<leader>fs      → Browse symbols in current file
gd              → Jump to definitions
gr              → Find all usages
<C-o>           → Jump back
```

### 2. Refactoring
```
<leader>rn      → Rename symbol (updates all references)
<leader>ca      → Code actions (extract, inline, etc.)
gr              → Verify all references updated
```

### 3. Quick Bug Fixing
```
<leader>xx      → Open diagnostics
<CR>            → Jump to error
<leader>ca      → Apply quick fix
]d              → Next diagnostic
```

### 4. Git Workflow
```
<leader>gd      → See what changed in file
<leader>gs      → Stage this hunk
:G              → Interactive status
:G commit       → Commit
```

### 5. Working with Multiple Files
```
<leader>ha      → Mark important files with harpoon
<leader>1-4     → Jump between them instantly
<C-p>           → Quick find for other files
```

---

## Treesitter Context

The current function/class shows at the top of the screen when you scroll down into large functions. No keybinding needed - it's automatic.

---

## Tips

1. **Use Harpoon** for files you edit together (component + test + types)
2. **Use Flash** (`s`) instead of searching for quick jumps
3. **Use `<C-f>`** (live grep) more than `<C-p>` when you know what you're looking for
4. **Learn text objects** - `daf` (delete function) and `cif` (change inside function) are game changers
5. **Format on save** is enabled - just save and Prettier runs automatically
