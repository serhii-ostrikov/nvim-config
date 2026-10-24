# My little neovim config!

## About AI usage
I mainly use LLMs to configure and mess around with config.


## Install

Needs Neovim **0.12+** (for the built-in `vim.pack` plugin manager) and `git`.

Copy and paste this. It moves any existing Neovim config, plugins and cache into `*.bak.<timestamp>` folders, clones this repo, and starts Neovim, which installs the plugins on first launch:

```sh
mkdir -p ~/.config/nvim
ts=$(date +%s)
for d in ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim; do
  [ -e "$d" ] && mv "$d" "$d.bak.$ts"
done
git clone https://github.com/serhii-ostrikov/nvim-config.git ~/.config/nvim
nvim
```

When you're happy with it, delete the backups:

```sh
rm -rf ~/.config/nvim.bak.* ~/.local/share/nvim.bak.* ~/.local/state/nvim.bak.* ~/.cache/nvim.bak.*
```

### Optional tools

- `ripgrep` for live grep (`<space>g`)
- `tree-sitter` CLI and a C compiler, so `nvim-treesitter` can build the markdown parsers
- Language servers, each used only if it's on your `PATH`: `zls`, `lua-language-server`, `terraform-ls`, `gopls`, `typescript-language-server`

See [KEYMAPS.md](KEYMAPS.md) for the keybindings.
