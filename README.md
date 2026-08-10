# Neovim Configuration

This directory contains the modern Neovim configuration migrated from the original Vim setup.

## Stack
- Lua configuration: `init.lua`
- Plugin manager: `lazy.nvim`
- LSP: Neovim built-in LSP with `nvim-lspconfig` and Mason
- Completion: `nvim-cmp`
- Syntax, indentation, and language support: Tree-sitter
- File picker and search: Telescope
- File tree: nvim-tree
- Formatting: conform.nvim
- Markdown rendering: render-markdown.nvim

The configuration intentionally removes the old Vim-only stack: vim-plug, vim-lsp, asyncomplete, vim-go, gocode, CtrlP, Ag, NERDTree, Tagbar, rainbow_parentheses, vim-autoformat, instant-markdown, and other legacy Vim plugins.

## Install

```sh
./install.sh
```

The script installs `init.lua` and `lua/` into `${XDG_CONFIG_HOME:-$HOME/.config}/nvim`. On first startup, `lazy.nvim` is bootstrapped automatically and plugins are installed.

Run these commands inside Neovim when needed:

```vim
:Lazy
:Mason
:TSUpdate
```

External tools used by formatters and language servers should be installed through Mason or the system package manager. Common tools include `clangd`, `gopls`, `pyright`, `typescript-language-server`, `rust-analyzer`, `clang-format`, `gofmt`, `ruff`, and `prettier`.

## Preserved shortcuts

The original leader remains `;`. Existing save, buffer, tab, window, clipboard, search, file-tree, formatting, and Go-oriented leader shortcuts remain available where their modern replacements provide the same behavior. LSP symbol outline is now `<leader>tl`; LSP hover is `<leader>lh`, avoiding the original `K` page-up mapping conflict.
