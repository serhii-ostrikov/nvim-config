# Neovim keymaps

## Custom keymaps (`<leader>` = `Space`)

### LSP (only active in buffers where a language server has attached)

| Key | Action |
|---|---|
| `<space>d` | go to definition |
| `<space>D` | go to type definition |
| `<space>h` | signature help |
| `<space>f` | format buffer via LSP |
| `<space>e` | show diagnostic under cursor |
| `<space>n` | next diagnostic |
| `<space>N` | previous diagnostic |
| `<space>s` | fuzzy-search symbols in current file |
| `<space>S` | live fuzzy-search symbols across project |

Also: any buffer with an LSP attached auto-formats on save (`BufWritePre`) — no keystroke needed.

### Finding things & git (global)

| Key | Action |
|---|---|
| `<space>g` | live full-text search (grep) across project |
| `<space>p` | fuzzy-find files by name |
| `-` | open file explorer (`mini.files`) at current file's directory |
| `]c` | jump to next changed git hunk |
| `[c` | jump to previous changed git hunk |

### Completion & editing (global)

| Key | Action |
|---|---|
| `Ctrl-Space` (insert) | manually trigger completion popup |
| `Tab` (insert) | if popup open → accept selected item; else if snippet active → jump to next placeholder; else → normal tab |
| `Alt-Backspace` (insert) | delete word before cursor |
| `Esc` (normal) | clear search highlight, on top of normal `Esc` behavior |

## Native Neovim behavior (nothing to configure)

| Key | Action |
|---|---|
| `Ctrl-i` / `Ctrl-o` | jump back / forward through cursor-position history (jumplist) — swapped from the defaults in `init.lua` |
| `Ctrl-n` / `Ctrl-p` (insert) | move down/up through the completion popup menu |
| `Shift-Tab` (insert/select) | jump to *previous* snippet placeholder |
| `Ctrl-w` (insert) | delete word before cursor |
| `Ctrl-s` (insert) | signature help |
| `Ctrl-y` (insert, popup open) | accept the currently selected completion item |
| `gi` | return to last insert position and resume insert mode (handy mid-snippet if you `Esc`'d out) |
| `g8` | show byte/hex values of character under cursor (useful for diagnosing what a key sends) |

## Settings changed (not keystrokes, but behavior)

- `ignorecase` + `smartcase` — completion and `/` search match case-insensitively unless you type a capital letter yourself.
- `completeopt` includes `noinsert` — the popup pre-highlights the first match without eagerly inserting it into your buffer.
