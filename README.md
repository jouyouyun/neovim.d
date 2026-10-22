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

## Requirements

- Neovim 0.12 or later (this configuration uses the current Tree-sitter `main` API).
- Git, a C compiler, `curl`, `tar`, and `tree-sitter` CLI 0.26.1 or later. Install the CLI through the system package manager or an official Tree-sitter release, not npm.
- `ripgrep` for Telescope live grep; a clipboard provider for system clipboard shortcuts.

## Install

```sh
./install.sh
```

The script installs `init.lua` and `lua/` into `${XDG_CONFIG_HOME:-$HOME/.config}/nvim`. This is a **copy**, not a symlink: run the script again after editing this repository, then restart Neovim. Existing sessions keep their loaded options.

On first startup, `lazy.nvim` is bootstrapped automatically and plugins are installed. The configured Tree-sitter parsers install asynchronously; already open buffers are retried when installation finishes. `:TSLog` shows parser installation failures, and `:TSInstall <language>` retries an individual parser. Plugin updates run `:TSUpdate`.

Run these commands inside Neovim when needed:

```vim
:Lazy
:Mason
:TSUpdate
```

External tools used by formatters and language servers should be installed through Mason or the system package manager. Emmet wrapping (`;xe` in normal or visual mode) requires `emmet-language-server` 2.2.0 or later; it is included in the Mason LSP installation list. If it has not yet installed, run `:MasonInstall emmet-language-server`.

Common tools include `clangd`, `gopls`, `pyright`, `typescript-language-server`, `rust-analyzer`, `clang-format`, `gofmt`, `ruff`, and `prettier`.

## Preserved shortcuts

The original leader remains `;`. Existing save, buffer, tab, window, clipboard, search, file-tree, formatting, and Go-oriented leader shortcuts remain available where their modern replacements provide the same behavior. LSP symbol outline is now `<leader>tl`; LSP hover is `<leader>lh`, avoiding the original `K` page-up mapping conflict.

## Mouse behavior

`mouse=i` enables Neovim mouse handling only in Insert mode. In Normal mode the terminal normally handles text selection; behavior also depends on the terminal. Mouse wheel behavior alone does not establish which configuration was loaded.

Inspect the active option and its source:

```vim
:verbose set mouse?
:echo stdpath('config')
:lua print(package.searchpath('config.options', package.path))
```

For an immediate change in an existing session, use `:set mouse=i`. If a repository edit appears ineffective, reinstall the configuration and restart Neovim; also check `NVIM_APPNAME` and `XDG_CONFIG_HOME` if the active configuration directory differs.

## Verification

Run the offline behavior checks from the repository root:

```sh
nvim --headless -u NONE -i NONE -l tests/config.lua
sh -n install.sh
```

The tests replace network installers and privileged writes. Actual parser/LSP downloads and terminal mouse behavior need integration checks on the target system.
