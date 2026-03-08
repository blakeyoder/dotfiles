# Neovim Usage Guide

Leader key is `<Space>`.

---

## File Navigation

### Telescope (Fuzzy Finding)
| Key | Action |
|-----|--------|
| `<C-p>` | Find git files |
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

---

## Editing

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

---

## Buffers & Windows

### Buffer Navigation (Bufferline)
| Key | Action |
|-----|--------|
| `<leader>l` | Next buffer |
| `<leader>h` | Previous buffer |
| `<leader>]` | Next buffer (alt) |
| `<leader>[` | Previous buffer (alt) |
| `<leader>bd` | Close buffer |
| `<leader>bp` | Pin/unpin buffer |
| `<leader>bo` | Close all other buffers |
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

## Markdown

Markdown files are rendered inline by `render-markdown.nvim`. Just open a `.md` file.

---

## Workflows

### Navigating a Codebase
```
<C-f>           -> Search for keywords in all files
<leader>fs      -> Browse symbols in current file
gd              -> Jump to definitions
gr              -> Find all usages
<C-o>           -> Jump back
```

### Refactoring
```
<leader>rn      -> Rename symbol (updates all references)
<leader>ca      -> Code actions (extract, inline, etc.)
gr              -> Verify all references updated
```

### Git Workflow
```
<leader>gd      -> See what changed in file
<leader>gs      -> Stage this hunk
:G              -> Interactive status
:G commit       -> Commit
```
