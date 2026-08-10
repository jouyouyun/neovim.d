local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none', '--branch=stable',
    'https://github.com/folke/lazy.nvim.git', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { 'nvim-lua/plenary.nvim', lazy = true },
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { defaults = { layout_strategy = 'horizontal', sorting_strategy = 'ascending' } },
  },
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFindFileToggle' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = { view = { width = 32, side = 'right' }, renderer = { icons = { show = { file = true, folder = true, folder_arrow = true } } }, filters = { dotfiles = false } },
  },
  {
    'stevearc/aerial.nvim',
    cmd = 'AerialToggle',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = { layout = { default_direction = 'right', max_width = { 32, 0.2 } }, show_guides = true },
  },
  { 'nvim-lualine/lualine.nvim', event = 'VeryLazy', dependencies = { 'nvim-tree/nvim-web-devicons' }, opts = { options = { globalstatus = true, theme = 'auto' }, extensions = { 'nvim-tree', 'quickfix' } } },
  { 'lewis6991/gitsigns.nvim', event = 'BufReadPre', opts = {} },
  { 'numToStr/Comment.nvim', event = 'VeryLazy', opts = {} },
  { 'echasnovski/mini.pairs', event = 'InsertEnter', opts = {} },
  { 'echasnovski/mini.ai', event = 'VeryLazy', opts = {} },
  { 'echasnovski/mini.surround', event = 'VeryLazy', opts = {} },
  { 'mg979/vim-visual-multi', event = 'VeryLazy' },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = { ensure_installed = { 'c', 'cpp', 'css', 'go', 'html', 'javascript', 'json', 'markdown', 'python', 'rust', 'typescript', 'vim', 'vue' }, auto_install = true, highlight = { enable = true }, indent = { enable = true } },
    config = function(_, opts) require('nvim-treesitter.configs').setup(opts) end,
  },
  { 'windwp/nvim-ts-autotag', ft = { 'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue' }, opts = {} },
  { 'HiPhish/rainbow-delimiters.nvim', event = { 'BufReadPost', 'BufNewFile' }, config = function() vim.g.rainbow_delimiters = { strategy = { [''] = require('rainbow-delimiters').strategy.global, vim = require('rainbow-delimiters').strategy['local'] }, query = { [''] = 'rainbow-blocks', lua = 'rainbow-blocks' }, priority = { [''] = 110, lua = 210 }, highlight = { 'RainbowRed', 'RainbowYellow', 'RainbowBlue', 'RainbowOrange', 'RainbowGreen', 'RainbowViolet', 'RainbowCyan' } } end },
  {
    'williamboman/mason.nvim', cmd = 'Mason', build = ':MasonUpdate', opts = {},
  },
  { 'williamboman/mason-lspconfig.nvim', dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' } },
  {
    'neovim/nvim-lspconfig', event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require('mason').setup()
      require('mason-lspconfig').setup({ ensure_installed = { 'clangd', 'gopls', 'pyright', 'ts_ls', 'rust_analyzer', 'lua_ls' } })
      local servers = { 'clangd', 'gopls', 'pyright', 'ts_ls', 'rust_analyzer', 'lua_ls' }
      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = capabilities })
        vim.lsp.enable(server)
      end
    end,
  },
  { 'hrsh7th/nvim-cmp', event = 'InsertEnter', dependencies = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' }, config = function() require('config.cmp') end },
  { 'stevearc/conform.nvim', event = { 'BufReadPre', 'BufNewFile' }, opts = { formatters_by_ft = { c = { 'clang_format' }, cpp = { 'clang_format' }, go = { 'gofmt' }, python = { 'ruff_format' }, javascript = { 'prettier' }, typescript = { 'prettier' }, html = { 'prettier' }, css = { 'prettier' }, rust = { 'rustfmt' } }, format_on_save = nil } },
  { 'olrtg/nvim-emmet', ft = { 'html', 'css', 'vue' }, opts = {} },
}, { change_detection = { notify = false }, checker = { enabled = false }, install = { missing = true } })
